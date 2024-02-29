//
//  GQButton.swift
//  GQPaymentIOSSDKNative
//
//  Created by valentine on 29/02/24.
//

import UIKit

class GQButton: UIButton {
    
    var enabledStateBackgroundColor: UIColor = .yellowFFCA00
    var disabledStateBackgroundColor: UIColor = .white

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        self.set(cornerRadius: 0.2, borderWidth: 1, borderColor: .grayDFDFE3)
        self.addShadow()
        
//        self.setDisabled()
    }
    
    func setDisabled() {
        Task { @MainActor in
            self.isEnabled = false
            self.setDisabledStateUI()
        }
    }
    
    func setEnabled() {
        Task { @MainActor in
            self.isEnabled = true
            self.setEnabledStateUI()
        }
    }
    
    func setTint(color: UIColor) {
        self.tintColor = color
        self.setTitleColor(color, for: .normal)
        self.setTitleColor(color, for: .disabled)
        self.setImage(self.currentImage?.withTintColor(color))
    }
    
    func setTitle(with font: UIFont? = .customFont(.dmSans, weight: .medium, size: 14)) {
        self.titleLabel?.font = font
    }
    
    func setEnabledStateUI() {
        self.backgroundColor = enabledStateBackgroundColor
    }
    
    func setDisabledStateUI() {
        self.backgroundColor = disabledStateBackgroundColor
    }

    func setImage(_ image: UIImage?, placement: NSDirectionalRectEdge = .trailing) {
        self.setImage(image?.withTintColor(self.tintColor), for: .normal)
        self.configuration?.imagePlacement = placement
    }
}
