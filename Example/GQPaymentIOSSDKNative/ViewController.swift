//
//  ViewController.swift
//  GQPaymentIOSSDKNative
//
//  Created by 1410avi on 02/19/2024.
//  Copyright (c) 2024 1410avi. All rights reserved.
//

import UIKit
import GQPaymentIOSSDKNative

class ViewController: UIViewController {
    
    @IBOutlet weak var clientIDTextField: UITextField!
    @IBOutlet weak var clientSecretKeyTextField: UITextField!
    @IBOutlet weak var apiKeyTextField: UITextField!
    @IBOutlet weak var environmentTextField: UITextField!
    @IBOutlet weak var studentIDTextField: UITextField!
    @IBOutlet weak var customerNumberTextField: UITextField!
    @IBOutlet weak var ppConfigTextField: UITextField!
    @IBOutlet weak var feeHeaderTextField: UITextField!
    @IBOutlet weak var themeColorTextField: UITextField!
    @IBOutlet weak var optionalDataTextField: UITextField!
    
    @IBOutlet weak var openSDKButton: UIButton!
    @IBOutlet weak var prefillButton: UIButton!
    @IBOutlet weak var callBackButton: UIButton!
    
    private var configObject: [String: Any]?
    private var responseObject: [String: Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        overrideUserInterfaceStyle = .light
        
        openSDKButton.backgroundColor = .systemIndigo
        openSDKButton.layer.cornerRadius = openSDKButton.frame.height * 0.2
        prefillButton.layer.cornerRadius = openSDKButton.frame.height * 0.2
        callBackButton.layer.cornerRadius = openSDKButton.frame.height * 0.2
    }
    
    private func setupConfig() {
        self.configObject = [
                                "auth": [
                                          "client_secret_key": clientSecretKeyTextField.text ?? "",
                                          "gq_api_key": apiKeyTextField.text ?? "",
                                          "client_id": clientIDTextField.text ?? ""
                                        ],
                                 "env": environmentTextField.text ?? "",
                                 "customer_number": customerNumberTextField.text ?? "",
                                 "student_id": studentIDTextField.text ?? "",
                                 "pp_config": ppConfigTextField.text ?? "",
                                 "fee_headers": feeHeaderTextField.text ?? "",
                                 "customization": [
                                                    "theme_color": themeColorTextField.text ?? ""
                                                  ],
                                 "optional_data": optionalDataTextField.text ?? ""
                            ]
    }
    
    @IBAction func clickedOpenSDKButton(_ sender: UIButton) {
        setupConfig()
//      MARK: Created Instance of GQPaymentSDK class and pass data, Then initialise it.
        Task { @MainActor in
            let gqPayment = GQPaymentSDK(clientData: self.configObject, delegate: self)
            self.present(gqPayment, animated: true)
        }
    }
    
    @IBAction func clickedPrefillButton(_ sender: UIButton) {
        Task { @MainActor in
            self.clientIDTextField.text = "GQ-0d2ed24e-cc1f-400b-a4e3-7208c88b99b5"
            self.clientSecretKeyTextField.text = "a96dd7ea-7d4a-4772-92c3-ac481713be4a"
            self.apiKeyTextField.text = "b59bf799-2a82-4298-b901-09c512ea4aaa"
            self.environmentTextField.text = "test"
            self.studentIDTextField.text = "demo_00023"
            self.customerNumberTextField.text = "8425900023"
            self.ppConfigTextField.text = "\(["slug": "masira-darvesh-gile"])"
            self.feeHeaderTextField.text = "\(["Payable_fee_EMI": "12000", "Payable_fee_PG": "100", "Payable_fee_Auto_Debit": "10000"])"
            self.themeColorTextField.text = ""
            self.optionalDataTextField.text = ""
        }
    }
    
    @IBAction func clickedCallBackButton(_ sender: UIButton) {
        Task { @MainActor in
            let alert = UIAlertController(title: "Response Callback", message: "\(self.responseObject ?? [:])", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
    }
    
    private func configureCallBack(state: Bool) {
        Task { @MainActor in
            self.callBackButton.isHidden = state
        }
    }
    
}

//MARK: GQPayment Delegate functions to receive payment status.
extension ViewController: GQPaymentDelegate {
    func gqSuccessResponse(data: [String : Any]?) {
        print("SDK Success!!!")
        self.responseObject = data
        configureCallBack(state: false)
    }
    
    func gqFailureResponse(data: [String : Any]?) {
        print("SDK Failure!!!")
        self.responseObject = data
        configureCallBack(state: false)
    }
    
    func gqCancelResponse(data: [String : Any]?) {
        print("Closed SDK!!!")
        self.responseObject = data
        configureCallBack(state: false)
    }
    
}
