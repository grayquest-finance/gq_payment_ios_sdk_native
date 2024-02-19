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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func clickedOpenSDKButton(_ sender: UIButton) {
//MARK: Created Instance of GQPayment class and called open function.
        let gqPayment = GQPayment(delegate: self)
        gqPayment.open(on: self)
    }
    

}

//MARK: GQPayment Delegate functions to receive payment status.
extension ViewController: GQPaymentDelegate {
    func gqPayment(_ gqPayment: GQPaymentIOSSDKNative.GQPayment, onSuccess data: [String : Any]?) {
        
    }
    
    func gqPayment(_ gqPayment: GQPaymentIOSSDKNative.GQPayment, onFailure data: [String : Any]?, error: Error) {
        
    }
    
    func gqPayment(_ gqPayment: GQPaymentIOSSDKNative.GQPayment, onCancel data: [String : Any]?) {
        
    }
    
}
