//
//  OTPTextField.swift
//  GQPaymentIOSSDKNative
//
//  Created by valentine on 20/02/24.
//

import UIKit

class OTPTextField: UITextField {
    weak var previousTextField: OTPTextField?
    weak var nextTextField: OTPTextField?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        self.borderStyle = .none
        self.textAlignment = .center
        self.textColor = .black
        self.set(cornerRadius:  0.05, borderWidth: 1, borderColor: .black)
        self.keyboardType = .numberPad
        
        self.previousTextField?.nextTextField = self
//        self.delegate =
    }
    
    override public func deleteBackward() {
        self.text = ""
        self.previousTextField?.becomeFirstResponder()
    }
}
