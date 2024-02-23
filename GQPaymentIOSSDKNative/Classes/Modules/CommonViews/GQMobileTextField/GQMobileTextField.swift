//
//  GQMobileTextField.swift
//  GQPaymentIOSSDKNative
//
//  Created by valentine on 21/02/24.
//

import UIKit

@MainActor protocol GQMobileTextFieldDelegate {
    func textField(_ textField: GQMobileTextField, didChange text: String?)
    func textField(_ textField: GQMobileTextField, didClick button: UIButton)
}

class GQMobileTextField: UIView {

    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var textFieldIcon: UIImageView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textFieldCode: UILabel!
    @IBOutlet weak var textFieldButton: UIButton!
    
    private var cornerRadius: CGFloat = 0.12
    
    public var text: String? {
        // Need to check format of Mobile Number
        return  (textFieldCode.text ?? "") + (textField.text ?? "")
    }
    
    public var delegate: (any GQMobileTextFieldDelegate)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        _ = UINib(nibName: "GQMobileTextField", bundle: GQPayment.bundle).instantiate(withOwner: self)
        self.addSubview(contentView)
        self.contentView.frame = self.bounds
        self.contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        self.contentView.backgroundColor = .whiteFAFCFD
        
        textfieldInactiveState()
        self.textFieldButton.set(cornerRadius: cornerRadius)
        
        self.textField.delegate = self
        self.textFieldIcon.image = .getImage(icon: .phoneIcon)
        
        setupStaticText()
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
        textFieldButton.setTitleColor(.gray807E8D, for: .disabled)
        textFieldButton.setTitleColor(.white, for: .normal)
        inactiveOTPState()
        
        textField.attributedPlaceholder = NSAttributedString(string: "Enter mobile number",
                                    font: .customFont(.dmSans, weight: .regular, size: 14),
                                                             color: .gray4D4B5A)
        
        textFieldCode.text = "+91 -"
        textFieldButton.setTitle("Send OTP", for: .normal)
        
        let textTrait = textField.text
        
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
            self.contentView.set(cornerRadius: cornerRadius, borderWidth: 1, borderColor: .grayBFBFC6)
        }
    }
    
    private func textfieldActiveState() {
        Task { @MainActor in
            self.contentView.set(cornerRadius: cornerRadius, borderWidth: 2, borderColor: .blue4029CC)
        }
    }
    
    @IBAction func clickedSendOTPButton(_ sender: UIButton) {
        delegate?.textField(self, didClick: sender)
    }
    
    @IBAction func textfieldTextChanged(_ sender: UITextField) {
        defer {
            delegate?.textField(self, didChange: self.text)
        }
        
        if GQValidationService.validate(mobileNumber: self.textField.text) {
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
        textfieldInactiveState()
    }
    
}
