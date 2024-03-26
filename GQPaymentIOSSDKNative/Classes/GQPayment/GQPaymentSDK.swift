//
//  GQPayment.swift
//  TestCases_Example
//
//  Created by valentine on 15/02/24.
//

import UIKit

final public class GQPaymentSDK: UIViewController, GQLoadable {
    
    internal static var entrance: GQPaymentSDK?
    
//    Theme Color to be displayed by the client.
    internal static var themeColor: UIColor = .red991F2C
    
//    Delegate which will receive payment callback.
    @objc public var delegate: (any GQPaymentDelegate)? {
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
            Self.entrance = self
        }
        
//        Setting Data and Configuration.
        self.clientJSONObject = clientData
        self.modalPresentationStyle = .overCurrentContext
        self.modalTransitionStyle = .crossDissolve
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        self.close()
    }
    
//        Loading Dependencies.
    private func loadDependencies() {
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
    
//    Tells the Log class that the SDK can print/ log data. True to print data.
    internal static var debugMode: Bool = true
    
    weak var loader: GQLoaderViewController?
    
    let environment = GQEnvironment.shared
    
//    The JSON Dictionary passed from client app.
    @objc public var clientJSONObject: [String: Any]?
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.showLoader()
        loadDependencies()
        configureSessionRequest()
    }
    
    private func configureSessionRequest() {
        guard let clientJSON = self.clientJSONObject else {
            Task {
                await self.handleError(description: "Requires JSON Object to proceed")
            }
            return
        }
        
        var errorMessage = [String]()
        var isInValid: Bool = false
        
        // Auth Requirements
        if let auth = clientJSON["auth"] as? JSONDictionary,
           let clientId = auth["client_id"] as? String,
           let clientSecret = auth["client_secret_key"] as? String,
           let apiKey = auth["gq_api_key"] as? String {
            environment.updateClientId(clientID: clientId)
            environment.updateClientSecret(clientSecret: clientSecret)
            environment.updateApiKey(apiKey: apiKey)
        } else {
            isInValid = true
            errorMessage.append("Auth is missing")
        }
        
        // Student ID Requirements
        if let studentID = clientJSON["student_id"] as? String {
            environment.updateStudentID(stdId: studentID)
        }else {
            isInValid = true
            errorMessage.append("Student Id is required")
        }
        
        // Environment Requirements
        if let env = clientJSON["env"] as? String, GQNetworkEnvironment.isValid(environment: env) {
                environment.update(environment: env)
        } else {
            isInValid = true
            errorMessage.append("Enter a valid Environment")
        }
        
        // PP Config Requirements
        if let ppConfig = clientJSON["pp_config"] as? JSONDictionary {
            if let slug = ppConfig["slug"] as? String, !slug.isEmpty {
                environment.updatePpConfig(ppConfig: ppConfig)
            } else {
                isInValid = true
                errorMessage.append("Slug is required")
            }
        }
        
        // Fee Headers Requirements
        if let feeHeaders = clientJSON["fee_headers"] as? JSONDictionary {
            environment.updateFeeHeaders(feeHeader: feeHeaders)
        }
        
        // Theme Requirements
        if let customization = clientJSON["customization"] as? JSONDictionary,
           let themeColor = customization["theme_color"] as? String {
            environment.updateTheme(color: themeColor)
            environment.updateCustomization(customization: customization)
        }
        
        // Mobile Number Requirements
        if let customerNumber = clientJSON["customer_number"] as? String {
            if GQValidationService.validate(mobileNumber: customerNumber) {
                environment.updateCustomerNumber(customerNumber: customerNumber)
            }else{
                isInValid = true
                errorMessage.append("Invalid customer number")
            }
        }
        
        // Needs Change
        environment.instituteLogo = "https://ezyschooling-1.s3.amazonaws.com/schools/logos/user_generic-school-user/VIBGYOR_High_School_2424_Logo_1.jpg"
        
        guard !isInValid else {
            Task {
                await self.handleError(description: errorMessage.joined(separator: ", "))
            }
            return
        }
        
        // Customer Data, Changed to Model or take dynamic values
        let customerData: JSONDictionary = [
            "session_data": [
                "gq_api_key": environment.gqApiKey,
                "client_secret_key": environment.clientSecret,
                "client_id": environment.clientID,
                "student_id": environment.studentID,
                "application_id": "",
                "api_base_url": GQNetworkEnvironment(rawValue: environment.env)?.baseURL ?? .empty,
                "env": environment.env,
                "user_type": "",
                "fee_helper_text": "",
                "payable_helper_text": "",
                "aBase64": environment.abase,
                "customer_id": environment.customerID,
                "customer_code": environment.customerCode,
                "student_details": [
                    "student_first_name": "",
                    "student_middle_name": "",
                    "student_last_name": "",
                    "student_type": "", //Existing or NEW
                    "customer_first_name": "",
                    "customer_last_name": ""
                ],
                "customer_details": [
                    "customer_dob": "1896-10-14",
                    "customer_email": "avi@mail.com",
                    "customer_first_name": "AviFirst",
                    "customer_gender": "MALE",
                    "customer_last_name": "AviLast",
                    "customer_marital_status": "OTHERS",
                ],
                "kyc_details": nil,
                "residential_details": nil,
                "employment_details": nil,
                "theme_color": environment.themeColor,
                "logo_url": environment.instituteLogo,
                "notes": nil,
                "financing_config": nil,
                "pp_config": environment.ppConfig,
                "fee_headers": environment.feeHeaders
            ],
            "customer_mobile": environment.customerMobileNumber
        ]
        
        startCustomerSession(with: customerData)
    }
    
    private func startCustomerSession(with data: JSONDictionary?) {
        guard let data else { return }
        
        Task(priority: .userInitiated) {
            do {
                let response = try await GQNetworkService.shared.perform(networkType: .customerSession, parameters: data, responseType: CustomerSessionResponse.self)
                self.handleAPIResult(response: response)
                self.hideLoader()
                self.open()
            } catch (let error) {
                await self.handleError(description: error.localizedDescription)
            }
        }
    }
    
    @MainActor private func handleError(description: String) async {
        self.hideLoader()
        self.dismiss(animated: true) {
            self.delegate?.gqFailureResponse(data: ["Error": description])
            GQLogger.shared.error(description)
        }
    }
    
     @MainActor private func open() {
        let mobileNumberViewmodel = EnterMobileNumberViewModel()
        let mobileNumberViewcontroller = EnterMobileNumberViewController(viewModel: mobileNumberViewmodel)
        mobileNumberViewcontroller.gqPaymentSDK = self
        
        let navigationController = UINavigationController(rootViewController: mobileNumberViewcontroller)
        navigationController.modalPresentationStyle = self.presentationStyle
        navigationController.modalTransitionStyle = self.transitionStyle
        
        navigationController.isModalInPresentation = true
        self.present(navigationController, animated: true)
    }
    
    func handleAPIResult(response: CustomerSessionResponse?) {
        guard let response else { return }
        
//        self.environment.updateCustomerType(custType: response.doesExist ? "existing" : "new")
        self.environment.updateCustomerCode(custCode: response.data?.customerCode)
        self.environment.updateCustomerId(custId: response.data?.customerID)
        self.environment.updateSDKSessionCode(sessionCode: response.data?.sdkSessionCode)
    }
    
//    Clearing all data used in SDK
    private func close() {
        ImageCache.shared.clearCache()
        GQEnvironment.shared.clear()
    }
        
}
