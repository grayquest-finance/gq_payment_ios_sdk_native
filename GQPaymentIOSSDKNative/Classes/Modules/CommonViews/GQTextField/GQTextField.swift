//
//  GQTextField.swift
//  GQPaymentIOSSDKNative
//
//  Created by valentine on 27/02/24.
//

import UIKit

class GQTextField: UIView {
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var textFieldIcon: UIImageView!
    
    @IBOutlet weak var textFieldTitle: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    
    private var cornerRadius: CGFloat = 0.12
    
    public var text: String? {
        return self.textField.text
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        _ = UINib(nibName: "GQTextField", bundle: GQPayment.bundle).instantiate(withOwner: self)
        self.addSubview(contentView)
        self.contentView.frame = self.bounds
        self.contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.backgroundColor = .clear
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        self.textField.delegate = self
        self.textFieldIcon.image = .getImage(icon: .otpIcon)
        
        setupStaticText()
        textfieldInactiveState()
    }
    
    private func setupStaticText() {
        textField.textColor = .black
        textField.font = .customFont(.dmSans, weight: .bold, size: 14)
        textField.textAlignment = .left
        
        textField.attributedPlaceholder = NSAttributedString(string: "Enter OTP",
                                    font: .customFont(.dmSans, weight: .regular, size: 14),
                                                             color: .gray4D4B5A)

    }
    
    private func textfieldInactiveState() {
        Task { @MainActor in
            self.textField.resignFirstResponder()
            self.contentView.backgroundColor = .whiteFAFCFD
            self.textField.isEnabled = true
            self.contentView.set(cornerRadius: cornerRadius, borderWidth: 1, borderColor: .grayBFBFC6)
        }
    }
    
    private func textfieldActiveState() {
        Task { @MainActor in
            self.contentView.backgroundColor = .whiteFAFCFD
            self.textField.isEnabled = true
            self.contentView.set(cornerRadius: cornerRadius, borderWidth: 2, borderColor: .blue4029CC)
            self.textField.becomeFirstResponder()
        }
    }
    
    public func configureForOTP() {
        Task { @MainActor in
            self.textFieldTitle.isHidden = true
        }
    }
    
    
}

extension GQTextField: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textfieldActiveState()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textfieldInactiveState()
    }
    
}
