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
        self.contentView.backgroundColor = .white
        self.contentView.set(cornerRadius: 0.1, borderWidth: 1, borderColor: .black)
        
        self.textFieldButton.set(cornerRadius: 0.2)
        setupStaticText()
    }
    
    private func setupStaticText() {
        textFieldCode.textColor = .black
        textFieldCode.font = .customFont(.dmSans, weight: .regular, size: 14)
        textFieldCode.numberOfLines = 0
        textFieldCode.lineBreakMode = .byWordWrapping
        textFieldCode.textAlignment = .left
        
        textField.textColor = .black
        textField.font = .customFont(.dmSans, weight: .bold, size: 14)
        textField.textAlignment = .left
        
        textFieldButton.backgroundColor = .darkGray
        textFieldButton.titleLabel?.font = .customFont(.dmSans, weight: .bold, size: 14)
        textFieldButton.tintColor = .black.withAlphaComponent(0.6)
        
        textFieldCode.text = "+91 -"
        textField.placeholder = "Enter mobile number"
        textFieldButton.setTitle("Send OTP", for: .normal)
    }
    
//    public func configure() {
//
//    }
    
}


