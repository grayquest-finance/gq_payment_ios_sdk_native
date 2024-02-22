//
//  GQMobileTextField.swift
//  GQPaymentIOSSDKNative
//
//  Created by valentine on 21/02/24.
//

import UIKit

class GQMobileTextField: UIView {

    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var textFieldIcon: UIImageView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textFieldCode: UILabel!
    @IBOutlet weak var textFieldButton: UIButton!
    
    public var text: String? {
        return  (textFieldCode.text ?? "") + (textField.text ?? "")
    }
    
    public var delegate: UITextFieldDelegate? {
        get {
            return textField.delegate
        }
        
        set {
            textField.delegate = newValue
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
        self.contentView.backgroundColor = .whiteFAFCFD
        
        let cornerRadius: CGFloat = 0.12
        self.contentView.set(cornerRadius: cornerRadius, borderWidth: 1, borderColor: .grayBFBFC6)
        self.textFieldButton.set(cornerRadius: cornerRadius)
        
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
        inactiveOTPState()
        
        textField.attributedPlaceholder = NSAttributedString(string: "Enter mobile number",
                                    font: .customFont(.dmSans, weight: .regular, size: 14),
                                                             color: .gray4D4B5A)
        
        textFieldCode.text = "+91 -"
        textFieldButton.setTitle("Send OTP", for: .normal)
    }
    
    func inactiveOTPState() {
        Task { @MainActor in
            self.textFieldButton.backgroundColor = .grayBFBFC6
            self.textFieldButton.tintColor = .gray807E8D
            self.textFieldButton.isEnabled = false
        }
    }
    
    func activeOTPState() {
        Task { @MainActor in
            self.textFieldButton.backgroundColor = .grayBFBFC6
            self.textFieldButton.tintColor = .gray807E8D
            self.textFieldButton.isEnabled = true
        }
    }
    
}
