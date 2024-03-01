//
//  GQMobileTextField.swift
//  GQPaymentIOSSDKNative
//
//  Created by valentine on 21/02/24.
//

import UIKit

class GQMobileTextField: UIView {
    
    enum State {
        case inactive
        case active
        case completed
        
        var title: String {
            switch self {
                case .inactive, .active:
                    return "Send OTP"
                case .completed:
                    return "Change"
            }
        }
    }

    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var textFieldIcon: UIImageView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textFieldCode: UILabel!
    @IBOutlet weak var textFieldButton: UIButton!
    
    private var cornerRadius: CGFloat = 0.12
    
    public var text: String? {
        // Need to check format of Mobile Number
        return  (textFieldCode.text ?? .empty) + (textField.text ?? .empty)
    }
    
    public var delegate: (any GQMobileTextFieldDelegate)?
    
    private var state: State = .inactive
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        self.loadNib()
        contentView.combine(with: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        self.textFieldButton.set(cornerRadius: cornerRadius)
        
        self.textField.delegate = self
        self.textField.keyboardType = .phonePad
        self.textFieldIcon.image = .getImage(icon: .phoneIcon)
        
        setupStaticText()
        
        textfieldInactiveState()
        inactiveOTPState()
    }
    
    private func setupStaticText() {
        textFieldCode.textColor = .gray4D4B5A
        textFieldCode.font = .customFont(.dmSans, weight: .regular, size: 14)
        textFieldCode.numberOfLines = 0
        textFieldCode.lineBreakMode = .byWordWrapping
        textFieldCode.textAlignment = .left
        
        textField.textColor = .black
        textField.font = .customFont(.dmSans, weight: .bold, size: 14)
        textField.textAlignment = .left
        
        textFieldButton.titleLabel?.font = .customFont(.dmSans, weight: .bold, size: 14)
        
        textField.attributedPlaceholder = NSAttributedString(string: "Enter mobile number",
                                    font: .customFont(.dmSans, weight: .regular, size: 14),
                                                             color: .gray4D4B5A)
        
        textFieldCode.text = "+91 -"
    }
    
    private func inactiveOTPState() {
        Task { @MainActor in
            self.textFieldButton.backgroundColor = .grayBFBFC6
            self.textFieldButton.tintColor = .gray807E8D
            self.textFieldButton.isEnabled = false
        }
    }
    
    private func activeOTPState() {
        Task { @MainActor in
            self.textFieldButton.backgroundColor = .purple63499D
            self.textFieldButton.tintColor = .white
            self.textFieldButton.isEnabled = true
        }
    }
    
    private func textfieldInactiveState() {
        Task { @MainActor in
            self.textField.resignFirstResponder()
            self.contentView.backgroundColor = .whiteFAFCFD
            self.textField.isEnabled = true
            self.contentView.set(cornerRadius: cornerRadius, borderWidth: 1, borderColor: .grayBFBFC6)
            self.state = .inactive
        }
    }
    
    private func textfieldActiveState() {
        Task { @MainActor in
            self.contentView.backgroundColor = .whiteFAFCFD
            self.textField.isEnabled = true
            self.contentView.set(cornerRadius: cornerRadius, borderWidth: 1, borderColor: .blue4029CC)
            self.textFieldButton.setTitle(State.active.title, for: .normal)
            self.textField.becomeFirstResponder()
            self.state = .active
        }
    }
    
    private func textFieldCompletedState() {
        Task { @MainActor in
            self.state = .completed
            self.textField.resignFirstResponder()
            self.contentView.backgroundColor = .grayDFDFE3
            self.textField.isEnabled = false
            self.contentView.set(cornerRadius: cornerRadius, borderWidth: 1, borderColor: .grayBFBFC6)
            self.textFieldButton.setTitle(State.completed.title, for: .normal)
        }
    }
    
    @IBAction func clickedActionButton(_ sender: UIButton) {
        switch state {
            case .inactive:
                self.textFieldCompletedState()
            case .active:
                self.textFieldCompletedState()
                self.delegate?.textFieldDidClickSendOTP(self)
            case .completed:
                self.delegate?.textFieldDidClickChange(self)
                self.textfieldActiveState()
        }
    }
    
    @IBAction func textfieldTextChanged(_ sender: UITextField) {
        if GQValidationService.validate(mobileNumber: sender.text) {
            activeOTPState()
        } else {
            inactiveOTPState()
        }
    }
    
}

extension GQMobileTextField: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textfieldActiveState()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard state != .completed else { return } //Danger: Please do not remove this condition
        textfieldInactiveState()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.isEmpty { return true }
        guard (textField.text?.count ?? 0) < 10, string.isOnlyDigits else { return false }
        return true
    }
    
}
