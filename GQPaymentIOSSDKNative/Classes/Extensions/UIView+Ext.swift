//
//  UIView+Ext.swift
//  TestCases_Example
//
//  Created by valentine on 13/02/24.
//

import UIKit

extension UIView {
    
    func set(cornerRadius: CGFloat) {
        self.layer.cornerRadius = self.frame.height * cornerRadius
        self.clipsToBounds = true
    }
    
    func set(cornerRadius: CGFloat, borderWidth: CGFloat = 2, borderColor: UIColor) {
        self.set(cornerRadius: cornerRadius)
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
    }
    
    func addShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black18274B.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 4
        self.layer.shadowPath = UIBezierPath(rect: CGRect(x: 0,
                                                          y: bounds.midY * 0.8,
                                                          width: bounds.width,
                                                          height: bounds.height * 0.65)).cgPath
    }
    
//MARK: Use this function to load an XIB file with a class.
    internal func loadNib() {
        let name = String(describing: Self.self)
        _ = UINib(nibName: name, bundle: GQPaymentSDK.bundle).instantiate(withOwner: self)
    }
    
//MARK: Use this function to attach any `contentView` with a view whose XIB is loaded.
    internal func combine(with view: UIView) {
        view.addSubview(self)
        self.frame = view.bounds
        self.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        view.backgroundColor = .clear
    }
    
}
