//
//  GQEnvironment.swift
//  GQPaymentIOSSDKNative
//
//  Created by valentine on 05/03/24.
//

import Foundation

class Environment {
    var env: String = "test"
    var gqApiKey: String = ""
    var clientID: String = "" {
        didSet {
            updateAbase()
        }
    }
    var clientSecret: String = "" {
        didSet {
            updateAbase()
        }
    }
    
    var abase: String?
    var customerNumber: String = ""
    var customerID: Int?
    var customerCode: String?
    var customerType: String = "new"
    var studentID: String = ""
    var theme: String = ""
    var customizationString: String = ""
    var ppConfigString: String = ""
    var feeHeadersString: String = ""
    
    static var source: String = "isdk"
    static var version: String = "\"1.1\""
    static var customerAPI: String = "v1/customer/create-customer"
    
    static let shared = Environment()
    
    private init() { }
    
    // Method to update values
    func update(environment: String) {
        self.env = environment
    }
    
    func updateApiKey(apiKey: String){
        self.gqApiKey = apiKey
    }
    
    func updateClientId(clientID: String){
        self.clientID = clientID
    }
    
    func updateClientSecret(clientSecret: String){
        self.clientSecret = clientSecret
    }
    
    func updateAbase(){
        self.abase = (self.clientID + ":" + self.clientSecret).encodeStringToBase64()
    }
    
    func updateCustomerNumber(customerNumber: String){
        self.customerNumber = customerNumber
    }
    
    func updateCustomerId(custId: Int?) {
        self.customerID = custId
    }
    
    func updateCustomerCode(custCode: String?){
        self.customerCode = custCode
    }
    
    func updateCustomerType(custType: String){
        self.customerType = custType
    }
    
    func updateStudentID(stdId: String){
        self.studentID = stdId
    }
    
    func updateTheme(theme: String){
        self.theme = theme
    }
    
    func updateCustomization(customization: String){
        self.customizationString = customization
    }
    
    func updatePpConfig(ppConfig: String){
        self.ppConfigString = ppConfig
    }
    
    func updateFeeHeaders(feeHeader: String){
        self.feeHeadersString = feeHeader
    }
    
    func baseURL() -> String{
        switch env{
        case "stage":
            return "https://erp-api-stage.graydev.tech/"
        case "preprod":
            return "https://erp-api-preprod.graydev.tech/"
        case "live":
            return "https://erp-api.grayquest.com/"
        default:
            return "https://erp-api.graydev.tech/"
        }
    }
    
    func webLoadURL() -> String{
        switch env{
        case "stage":
            return "https://erp-sdk-stage.graydev.tech/"
        case "preprod":
            return "https://erp-sdk-preprod.graydev.tech/"
        case "live":
            return "https://erp-sdk.grayquest.com/"
        default:
            return "https://erp-sdk.graydev.tech/"
        }
    }
    
    func clear() {
        update(environment: "test")
        updateClientId(clientID: "")
        updateClientSecret(clientSecret: "")
        updateApiKey(apiKey: "")
//        updateAbase(abase: "")
        updateCustomerNumber(customerNumber: "")
        updateCustomerId(custId: 0)
        updateCustomerCode(custCode: "")
        updateCustomerType(custType: "")
        updateStudentID(stdId: "")
        updateTheme(theme: "")
        updateCustomization(customization: "")
        updatePpConfig(ppConfig: "")
        updateFeeHeaders(feeHeader: "")
    }
}
