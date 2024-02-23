//
//  GQMobileTextField.swift
//  GQPaymentIOSSDKNative
//
//  Created by valentine on 21/02/24.
//

import UIKit

@MainActor protocol GQMobileTextFieldDelegate {
    func textFieldDidClickSendOTP(_ textField: GQMobileTextField)
    func textFieldDidClickChange(_ textField: GQMobileTextField)
}

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
        return  (textFieldCode.text ?? "") + (textField.text ?? "")
    }
    
    public var delegate: (any GQMobileTextFieldDelegate)?
    
    private var state: State = .inactive {
        didSet {
            self.textFieldButton.setTitle(self.state.title, for: .normal)
        }
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
        self.textFieldButton.set(cornerRadius: cornerRadius)
        
        self.textField.delegate = self
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
        textFieldButton.setTitleColor(.gray807E8D, for: .disabled)
        textFieldButton.setTitleColor(.white, for: .normal)
        
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
            self.contentView.backgroundColor = .whiteFAFCFD
//            self.textField.isEnabled = true
            self.contentView.set(cornerRadius: cornerRadius, borderWidth: 1, borderColor: .grayBFBFC6)
            self.state = .inactive
        }
    }
    
    private func textfieldActiveState() {
        Task { @MainActor in
            self.contentView.backgroundColor = .whiteFAFCFD
            self.textField.isEnabled = true
            self.contentView.set(cornerRadius: cornerRadius, borderWidth: 2, borderColor: .blue4029CC)
            self.state = .active
        }
    }
    
    private func textFieldCompletedState() {
        Task { @MainActor in
            self.contentView.backgroundColor = .grayDFDFE3
            self.textField.isEnabled = false
            self.contentView.set(cornerRadius: cornerRadius, borderWidth: 2, borderColor: .grayBFBFC6)
            self.state = .completed
        }
    }
    
    @IBAction func clickedActionButton(_ sender: UIButton) {
        self.textField.endEditing(true)
        
        switch self.state {
            case .inactive:
                textfieldInactiveState()
            case .active:
                delegate?.textFieldDidClickSendOTP(self)
                textFieldCompletedState()
            case .completed:
                delegate?.textFieldDidClickChange(self)
                textfieldActiveState()
        }
    }
    
    @IBAction func textfieldTextChanged(_ sender: UITextField) {
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
