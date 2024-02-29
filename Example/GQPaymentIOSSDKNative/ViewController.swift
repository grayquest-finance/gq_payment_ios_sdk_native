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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        openSDKButton.backgroundColor = themeColor
        openSDKButton.layer.cornerRadius = openSDKButton.frame.height * 0.2
    }
    
    @IBAction func clickedOpenSDKButton(_ sender: UIButton) {
//      MARK: Created Instance of GQPayment class and called open function.
        let gqPayment = GQPayment(delegate: self)
        gqPayment.setTheme(color: themeColor)
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
