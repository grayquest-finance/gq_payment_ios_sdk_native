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
//        self.clipsToBounds = true
    }
    
    func set(cornerRadius: CGFloat, borderWidth: CGFloat = 2, borderColor: UIColor) {
        self.set(cornerRadius: cornerRadius)
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
    }
    
//    func connect(with view: UIView) {
//        let name = String(describing: self)
//        _ = UINib(nibName: name, bundle: Bundle(for: type(of: self))).instantiate(withOwner: self)
//        view.addSubview(self)
//        self.frame = view.bounds
//        self.autoresizingMask = [.flexibleHeight, .flexibleWidth]
//    }
    
}
