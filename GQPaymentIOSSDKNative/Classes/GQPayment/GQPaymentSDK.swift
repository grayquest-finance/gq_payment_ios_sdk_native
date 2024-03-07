//
//  GQPayment.swift
//  TestCases_Example
//
//  Created by valentine on 15/02/24.
//

import UIKit

final public class GQPaymentSDK: GQBaseViewController {
    
//    Theme Color to be displayed by the client.
    public static var themeColor: UIColor = .red991F2C
    
//    Delegate which will receive payment callback.
    public var delegate: (any GQPaymentDelegate)? {
        didSet {
            GQUtility.shared.delegate = self.delegate
        }
    }
    
//    Initialise the class with certain properties
    public init(clientData: [String: Any]?, delegate: some GQPaymentDelegate) {
        super.init(nibName: nil, bundle: nil)
        
        defer {
//            Needs to be called in defer since else didSet wont work.
            self.delegate = delegate
        }
        
//        Loading Dependencies.
        Self.loadDependencies()
        
//        Setting Data and Configuration.
        self.clientJSONObject = clientData
        self.modalPresentationStyle = .overCurrentContext
        self.modalTransitionStyle = .crossDissolve
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private static func loadDependencies() {
        UIFont.loadFonts()
    }
    
//    Presentation Style for the Initial Viewcontroller.
    public var presentationStyle: UIModalPresentationStyle = .pageSheet
    
//    Transition Style for the initial Viewcontroller.
    public var transitionStyle: UIModalTransitionStyle = .coverVertical
    
//    Framework bundle where it will be installed in client app.
    internal static var bundle: Bundle {
        return Bundle(for: Self.self)
    }
    
//    Tells the Log class that the SDK ca print/ log data. True to print data.
    internal static var debugMode: Bool = true
    
    var environment = Environment.shared
    
    public var clientJSONObject: [String: Any]?
    private var mobileNumber: String = ""
    private var errorMessage: String = ""
    private var isInValid: Bool = false
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        self.showLoader()
        configureClientJSONData()
    }
    
    private func configureClientJSONData() {
        if let jsonString = GQUtility.convertDictionaryToJson(dictionary: clientJSONObject ?? ["errpr":"Invalid JSON Object"]) {
            Environment.shared.clear()
            if let jsonData = jsonString.data(using: .utf8) {
                do {
                    if let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                        // Accessing values
                        if let auth = json["auth"] as? [String: Any],
                           let clientId = auth["client_id"] as? String,
                           let clientSecret = auth["client_secret_key"] as? String,
                           let apiKey = auth["gq_api_key"] as? String {
                            environment.updateClientId(clientID: clientId)
                            environment.updateClientSecret(clientSecret: clientSecret)
                            environment.updateApiKey(apiKey: apiKey)
                        } else {
                            isInValid = true
                            errorMessage += "Auth is missing"
                            print("No Auth Object available")
                        }
                        
                        if let studentID = json["student_id"] as? String {
                            environment.updateStudentID(stdId: studentID)
                        }else {
                            isInValid = true
                            errorMessage += ", Student Id is required"
                        }
                        
                        if let env = json["env"] as? String {
                            if GQValidationService.containsAnyValidEnvironment(env){
                                environment.update(environment: env)
                            }else{
                                isInValid = true
                                errorMessage += ", Invalid environment"
                            }
                        }else{
                            isInValid = true
                            errorMessage += ", Environment is required"
                        }
                        
                        if let customization = json["customization"] as? [String: Any],
                           let theme_color = customization["theme_color"] as? String {
                            environment.updateTheme(theme: theme_color)
                            if let customizationData = try? JSONSerialization.data(withJSONObject: customization as Any, options: .prettyPrinted),
                               let customizationString = String(data: customizationData, encoding: .utf8) {
                                environment.updateCustomization(customization: customizationString)
                            } else {
//                                print("Error converting customization to JSON string.")
                            }
                        }
                        
                        if var ppConfig = json["pp_config"] as? [String: Any]{
                            if let slug = ppConfig["slug"] as? String, !slug.isEmpty {
                                if let ppConfigData = try? JSONSerialization.data(withJSONObject: ppConfig as Any, options: .prettyPrinted),
                                   let ppConfigString = String(data: ppConfigData, encoding: .utf8) {
                                    environment.updatePpConfig(ppConfig: ppConfigString)
                                } else {
                                    isInValid = true
                                    errorMessage += ", Invalid PP Config Object"
                                }
                            } else {
                                isInValid = true
                                errorMessage += ", Slug is required"
                            }
                        } else {
//                            print("ppConfig Not avaibale")
                        }
                        
                        if var feeHeaders = json["fee_headers"] as? [String: Any]{
                            if let feeHeadersData = try? JSONSerialization.data(withJSONObject: feeHeaders as Any, options: .prettyPrinted),
                               let feeHeadersString = String(data: feeHeadersData, encoding: .utf8) {
                                environment.updateFeeHeaders(feeHeader: feeHeadersString)
                            } else {
                                isInValid = true
                                errorMessage += ", Invalid Fee Headers Object"
                            }
                        } else {
//                            print("Fee Headers Not avaibale")
                        }
                        
                        if let customerNumber = json["customer_number"] as? String {
                            if GQValidationService.validate(mobileNumber: customerNumber) {
                                environment.updateCustomerNumber(customerNumber: customerNumber)
                                mobileNumber = customerNumber
                                
                                
                            }else{
                                isInValid = true
                                errorMessage += ", Invalid customer number"
                            }
                        }else{
//                            print("Customer Number Not Available ")
                        }
                    } else {
                        isInValid = true
                        errorMessage += ", Invalid JSON Object"
                    }
                } catch {
                    isInValid = true
                    errorMessage += ", Invalid JSON Object"
                }
            } else {
                isInValid = true
                errorMessage += ", Invalid JSON Object"
            }
        } else {
            isInValid = true
            errorMessage += ", Invalid JSON Object"
        }
        
        if isInValid {
            let errorObject: [String: Any] = [
                "error": errorMessage
            ]
            DispatchQueue.main.async {
                self.delegate?.gqFailureResponse(data: errorObject)
            }
        }else{
            if mobileNumber.isEmpty{
                environment.updateCustomerType(custType: "new")
                getURL()
            }else{
                let parameters: [String: Any] = [
                    "customer_mobile": "\(environment.customerNumber)",
                ]
                self.fetchCustomer(with: parameters)
            }
        }
    }
    
    private func fetchCustomer(with data: JSONDictionary?) {
        guard let data else { return }
        
        Task(priority: .userInitiated) {
            do {
                let response = try await NetworkService.shared.perform(networkType: .createCustomer(data), responseType: CreateCustomerResponse.self)
                self.hideLoader()
                self.open()
            } catch (let error) {
                GQLogger.shared.error(error.localizedDescription)
                self.hideLoader()
                self.dismiss(animated: true)
            }
        }
    }
    
    public func open() {
        Task { @MainActor in
            let mobileNumberViewmodel = EnterMobileNumberViewModel()
            let mobileNumberViewcontroller = EnterMobileNumberViewController(viewModel: mobileNumberViewmodel)
            mobileNumberViewcontroller.gqPaymentSDK = self
            
//        MARK: For Using Inbuilt Navigation BAR
            let navigationController = UINavigationController(rootViewController: mobileNumberViewcontroller)
            navigationController.modalPresentationStyle = self.presentationStyle
            navigationController.modalTransitionStyle = self.transitionStyle
            
            navigationController.isModalInPresentation = true
            self.present(navigationController, animated: true)
        }
    }
    
    func handleAPIResult(responseObject: [String: Any]?, error: String?) {
        if let error = error {
            // Handle error
//            print("API Error: \(error)")
            let errorObject: [String: Any] = [
                "error": error
            ]
            self.delegate?.gqFailureResponse(data: errorObject)
        } else if let responseObject = responseObject {
            DispatchQueue.main.async {
                let message = responseObject["message"] as! String
                
                if (message == "Customer Exists") {
//                    print("existing")
                    self.environment.updateCustomerType(custType: "existing")
                }
                else {
//                    print("new")
                    self.environment.updateCustomerType(custType: "new")
                }
                
                let data = responseObject["data"] as! [String:AnyObject]
//                print("ResponseData: \(data)")
                self.environment.updateCustomerCode(custCode: data["customer_code"] as! String)
                self.environment.updateCustomerId(custId: data["customer_id"] as! Int)
                
                self.getURL()
            }
        }
    }
    
    private func getURL(){
        
        var webloadUrl: String = ""
        
        let baseURL = self.environment.webLoadURL()
        
        webloadUrl = baseURL
        
        webloadUrl += "instant-eligibility?gapik=\(environment.gqApiKey)"
        
        webloadUrl += "&abase=\(environment.abase ?? .empty)"
        
        webloadUrl += "&sid=\(environment.studentID)"
        
        if !environment.customerNumber.isEmpty{
            webloadUrl += "&m=\(environment.customerNumber)"
        }
        
        webloadUrl += "&env=\(environment.env)"
        
        if environment.customerID != 0{
            webloadUrl += "&cid=\(environment.customerID)"
        }
        
        if !environment.customerCode.isEmpty {
            webloadUrl += "&ccode=\(environment.customerCode)"
        }
        
        if !environment.theme.isEmpty {
            webloadUrl += "&pc=\(environment.theme)"
        }
        
        webloadUrl += "&s=\(Environment.source)"
        webloadUrl += "&user=\(environment.customerType)"
        
        if !environment.customizationString.isEmpty{
            webloadUrl += ""
        }
        
        if !environment.ppConfigString.isEmpty {
            webloadUrl += "&_pp_config=\(environment.ppConfigString)"
        }
        
        if !environment.feeHeadersString.isEmpty {
            webloadUrl += "&_fee_headers=\(environment.feeHeadersString)"
        }
        
        webloadUrl += "&_v=\(Environment.version)"
        
//        print("Complete WebUrl: \(webloadUrl)")
        
    }
        
}
