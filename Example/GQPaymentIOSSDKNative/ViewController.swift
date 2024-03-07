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
    
    @IBOutlet weak var openSDKButton: UIButton!
    
    private var themeColor: UIColor = .red991F2C
    
    private var configObject: [String: Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupConfig()
    }
    
    private func setupConfig() {
        self.configObject = ["auth": ["client_secret_key": "a96dd7ea-7d4a-4772-92c3-ac481713be4a",
                                      "gq_api_key": "b59bf799-2a82-4298-b901-09c512ea4aaa",
                                      "client_id": "GQ-0d2ed24e-cc1f-400b-a4e3-7208c88b99b5"
                                     ],
                             "env": "test",
                             "customer_number": "8425900023",
                             "student_id": "demo_00023",
                             "pp_config": ["slug": "masira-darvesh-gile"],
                                        "fee_headers": ["Payable_fee_EMI": "12000",
                                                        "Payable_fee_PG": "100",
                                                        "Payable_fee_Auto_Debit": "10000"
                                                       ]
                            ]
    }
    
    private func setupUI() {
        openSDKButton.backgroundColor = themeColor
        openSDKButton.layer.cornerRadius = openSDKButton.frame.height * 0.2
    }
    
    @IBAction func clickedOpenSDKButton(_ sender: UIButton) {
//      MARK: Created Instance of GQPayment class and called open function.
        DispatchQueue.main.async {
            let gqPayment = GQPaymentSDK(clientData: self.configObject, delegate: self)
            self.present(gqPayment, animated: true)
        }
    }
    

}

//MARK: GQPayment Delegate functions to receive payment status.
extension ViewController: GQPaymentDelegate {
    func gqSuccessResponse(data: [String : Any]?) {
        print("SDK Success!!!")
        if let data {
            print("Data: \(data)")
        }
    }
    
    func gqFailureResponse(data: [String : Any]?) {
        print("SDK Failure!!!")
        if let data {
            print("Data: \(data)")
        }
    }
    
    func gqCancelResponse(data: [String : Any]?) {
        print("Closed SDK!!!")
        if let data {
            print("Data: \(data)")
        }
    }
    
}
