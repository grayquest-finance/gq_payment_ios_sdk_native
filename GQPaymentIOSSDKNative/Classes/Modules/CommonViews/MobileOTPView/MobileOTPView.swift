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
    
    @IBOutlet var textfields: [UITextField]!
    
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
//        setupUI()
    }
    
    private func setupUI() {
//        let name = String(describing: self)
        UINib(nibName: "MobileOTPView", bundle: Bundle(for: type(of: self))).instantiate(withOwner: self)
        self.addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        contentView.backgroundColor = .white
        
        var count = 1
        textfields.forEach {
            $0.borderStyle = .none
            $0.textAlignment = .center
            $0.textColor = .black
            $0.font = .systemFont(ofSize: self.bounds.height * 0.6, weight: .medium)
            $0.set(cornerRadius:  0.05, borderWidth: 1, borderColor: .black)
            $0.keyboardType = .numberPad
            $0.delegate = self
            $0.tag = count
            count += 1
        }
    }
    
    
    

}

// MARK: 
extension MobileOTPView: UITextFieldDelegate {
    
    private func goToNextTextField(textField: UITextField) {
        guard textField.tag < textfields.endIndex else { return }
        
        let next = textfields[textField.tag]
        Task { @MainActor in
            next.becomeFirstResponder()
        }

    }
    
    private func goToPreviousTextField(textField: UITextField) {
        guard textField.text?.isEmpty ?? true else { return }
        guard textField.tag - 1 >= textfields.startIndex else { return }
        
        let previous = textfields[textField.tag - 1]
        Task { @MainActor in
            previous.becomeFirstResponder()
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if string.isEmpty {
            defer {
                goToPreviousTextField(textField: textField)
            }
            return true
        } else {
            guard let _ = Int(string) else { return false }
            defer {
                goToNextTextField(textField: textField)
            }
            guard textField.text?.count ?? 0 == 0 else { return false }
            return true
        }
    
    }

}
