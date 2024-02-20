//
//  MobileOTPView.swift
//  TestCases_Example
//
//  Created by valentine on 16/02/24.
//

import UIKit

class MobileOTPView: UIView {
    
    //MARK: IBOutlets
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet var textfields: [OTPTextField]!
    
    //MARK: Variables
    var isCompleted: Bool {
        return textfields.allSatisfy { ($0.text?.isEmpty ?? true) == false }
    }
    
    var getOTP: String? {
        let otp = textfields.reduce("", { $0 + ($1.text ?? "") })
        
        if otp.isEmpty {
            return nil
        } else {
            return otp
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func setupUI() {
//        let name = String(describing: self)
        UINib(nibName: "MobileOTPView", bundle: Bundle(for: type(of: self))).instantiate(withOwner: self)
        self.addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        contentView.backgroundColor = .white
        
        var prev: OTPTextField?
        textfields.forEach {
            $0.font = .systemFont(ofSize: self.bounds.height * 0.6, weight: .medium)
            $0.delegate = self
            
            $0.previousTextField = prev
            prev?.nextTextField = $0
            prev = $0
        }
    }

}

// MARK: Handling Traversing to Next TextField for OTPs
extension MobileOTPView: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range:NSRange,
                   replacementString string: String) -> Bool {
        guard let textField = textField as? OTPTextField else { return true }
        if string.count > 1 {
//            textField.resignFirstResponder()
//            autoFillTextField(with: string)
            return false
        } else {
            if (range.length == 0){
                if textField.nextTextField == nil {
                    textField.text? = string
                    textField.resignFirstResponder()
                }else{
                    textField.text? = string
                    textField.nextTextField?.becomeFirstResponder()
                }
                return false
            }
            return true
        }
    }

}
