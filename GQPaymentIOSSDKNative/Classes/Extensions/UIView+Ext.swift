//
//  UIView+Ext.swift
//  TestCases_Example
//
//  Created by valentine on 13/02/24.
//

import UIKit

extension UIView {
    
    public func set(cornerRadius: CGFloat) {
        self.layer.cornerRadius = self.frame.height * cornerRadius
//        self.clipsToBounds = true
    }
    
    public func set(cornerRadius: CGFloat, borderWidth: CGFloat = 2, borderColor: UIColor) {
        self.set(cornerRadius: cornerRadius)
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
    }
    
//    public func addContentViewAsOwner() {
//        let name = String(describing: self)
//        UINib(nibName: name, bundle: nil).instantiate(withOwner: self)
//        self.addSubview(view)
//        view.frame = self.bounds
//        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
//    }
    
}
