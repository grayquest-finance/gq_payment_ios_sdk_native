//
//  GQEnvironment.swift
//  GQPaymentIOSSDKNative
//
//  Created by valentine on 05/03/24.
//

import Foundation

class GQEnvironment {
    
    var env: String = "test" {
        didSet {
            if let environment = GQNetworkEnvironment(rawValue: env) {
                GQNetworkType.set(environment: environment)
            }
        }
    }
    
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
    var customerMobileNumber: String = ""
    var customerID: Int?
    var customerCode: String?
    var customerType: String = "new"
    var studentID: String = ""
    var customization: JSONDictionary?
    var ppConfig: JSONDictionary?
    var feeHeaders: JSONDictionary?
    
    var themeColor: String? {
        didSet {
//            GQPaymentSDK.themeColor = UIColor
        }
    }
    
    // Institute Details
    var instituteLogo: String? = "https://ezyschooling-1.s3.amazonaws.com/schools/logos/user_generic-school-user/VIBGYOR_High_School_2424_Logo_1.jpg"
    
    // Session Codes
    var sdkSessionCode: String?
    
    static let source: String = "isdk"
    static let version: String = "1.1"
    
    static let shared = GQEnvironment()
    private init() { }
    
    // Method to update values
    func update(environment: String) {
        self.env = environment
    }
    
    func updateApiKey(apiKey: String) {
        self.gqApiKey = apiKey
    }
    
    func updateClientId(clientID: String) {
        self.clientID = clientID
    }
    
    func updateClientSecret(clientSecret: String) {
        self.clientSecret = clientSecret
    }
    
    private func updateAbase() {
        self.abase = (self.clientID + ":" + self.clientSecret).encodeStringToBase64()
    }
    
    func updateCustomerNumber(customerNumber: String) {
        self.customerMobileNumber = customerNumber
    }
    
    func updateCustomerId(custId: Int?) {
        self.customerID = custId
    }
    
    func updateCustomerCode(custCode: String?) {
        self.customerCode = custCode
    }
    
    func updateCustomerType(custType: String) {
        self.customerType = custType
    }
    
    func updateStudentID(stdId: String) {
        self.studentID = stdId
    }
    
    func updateTheme(theme: String) {
        self.themeColor = theme
    }
    
    func updateCustomization(customization: JSONDictionary?) {
        self.customization = customization
    }
    
    func updatePpConfig(ppConfig: JSONDictionary?) {
        self.ppConfig = ppConfig
    }
    
    func updateFeeHeaders(feeHeader: JSONDictionary?) {
        self.feeHeaders = feeHeader
    }
    
    func updateSDKSessionCode(sessionCode: String?) {
        self.sdkSessionCode = sessionCode
    }
    
    func clear() {
        update(environment: "test")
        updateClientId(clientID: "")
        updateClientSecret(clientSecret: "")
        updateApiKey(apiKey: "")
        updateCustomerNumber(customerNumber: "")
        updateCustomerId(custId: 0)
        updateCustomerCode(custCode: "")
        updateCustomerType(custType: "")
        updateStudentID(stdId: "")
        updateTheme(theme: "")
        updateCustomization(customization: nil)
        updatePpConfig(ppConfig: nil)
        updateFeeHeaders(feeHeader: nil)
    }
}
