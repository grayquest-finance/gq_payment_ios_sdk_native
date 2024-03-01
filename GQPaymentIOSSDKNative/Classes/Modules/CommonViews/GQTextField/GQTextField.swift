//
//  GQTextField.swift
//  GQPaymentIOSSDKNative
//
//  Created by valentine on 27/02/24.
//

import UIKit

class GQTextField: UIView {
    
    enum State {
        case active
        case inactive
        case error
    }
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var textFiledView: UIView!
    
    @IBOutlet weak var textFieldIcon: UIImageView!
    
    @IBOutlet weak var textFieldTitle: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    public var delegate: (any GQTextFieldDelegate)?
    
    private var cornerRadius: CGFloat = 0.12
    public var isTitleEnabled: Bool = false
    
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    public var title: String? {
        didSet {
            add(newTitle: self.title)
        }
    }
    
    public var text: String? {
        return self.textField.text
    }
    
    private var state: GQTextField.State = .inactive
    
    public var onlyDigits: Bool = false {
        didSet {
            if onlyDigits {
                self.textField.keyboardType = .numberPad
            } else {
                self.textField.keyboardType = .default
            }
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
        self.loadNib()
        contentView.combine(with: self)
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
        textFieldTitle.isHidden = true
        errorMessageLabel.isHidden = true
    }
    
    private func setupStaticText() {
        textField.textColor = .black
        textField.font = .customFont(.dmSans, weight: .bold, size: 14)
        textField.textAlignment = .left
        
        errorMessageLabel.textColor = .redA82B10
        errorMessageLabel.font = .customFont(.dmSans, weight: .medium, size: 14)
        errorMessageLabel.numberOfLines = 0
        errorMessageLabel.lineBreakMode = .byWordWrapping
        errorMessageLabel.textAlignment = .left
    }
    
    private func add(newTitle: String?) {
        guard let newTitle else { return }
        Task { @MainActor in
            self.textFieldTitle.text = newTitle
            self.textField.attributedPlaceholder = NSAttributedString(string: newTitle,
                                        font: .customFont(.dmSans, weight: .regular, size: 14),
                                                                 color: .gray4D4B5A)
        }
    }
    
    private func textfieldInactiveState() {
        Task { @MainActor in
            self.textField.resignFirstResponder()
            self.textFiledView.backgroundColor = .whiteFAFCFD
            self.textField.isEnabled = true
            self.textFiledView.set(cornerRadius: cornerRadius, borderWidth: 1, borderColor: .grayBFBFC6)
            self.state = .inactive
        }
    }
    
    private func textfieldActiveState() {
        Task { @MainActor in
            self.textFiledView.backgroundColor = .whiteFAFCFD
            self.textField.isEnabled = true
            self.textFiledView.set(cornerRadius: cornerRadius, borderWidth: 1, borderColor: .blue4029CC)
            self.textField.becomeFirstResponder()
            self.state = .active
        }
    }
    
    public func assignErrorState(message: String) {
        Task { @MainActor in
            self.textFiledView.set(cornerRadius: cornerRadius, borderWidth: 1, borderColor: .redD23614)
            self.errorMessageLabel.text = message
            self.errorMessageLabel.isHidden = false
            self.state = .error
        }
    }
    
    public func resignErrorState() {
        Task { @MainActor in
            self.textFiledView.set(cornerRadius: cornerRadius, borderWidth: 1, borderColor: .blue4029CC)
            self.errorMessageLabel.isHidden = true
            self.state = .active
        }
    }
    
    public func clear() {
        Task { @MainActor in
            self.textField.text = .empty
        }
    }
    
    @IBAction func textFieldOnChangeText(_ sender: UITextField) {
        delegate?.textField(self, didChange: self.text)
    }
    
    
}

extension GQTextField: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textfieldActiveState()
        delegate?.textFieldDidBeginEditing(self)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if isTitleEnabled {
            Task { @MainActor in
                self.textFieldTitle.isHidden = false
            }
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if isTitleEnabled, textField.text?.isEmpty ?? true {
            Task { @MainActor in
                self.textFieldTitle.isHidden = false
            }
        }
        delegate?.textFieldDidEndEditing(self)
        if self.state != .error {
            textfieldInactiveState()
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.isEmpty { return true }
        
        if onlyDigits {
            if string.isOnlyDigits {
                return true
            } else {
                return false
            }
        }
        
        return true
    }

}
