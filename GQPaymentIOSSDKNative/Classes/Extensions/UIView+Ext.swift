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
//        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black18274B.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowOpacity = 0.4
        self.layer.shadowRadius = 0.5
//        layer.shadowPath = UIBezierPath(rect: CGRect(x: 0,
//                                                        y: bounds.maxY - layer.shadowRadius,
//                                                        width: bounds.width,
//                                                        height: layer.shadowRadius)).cgPath
    }
    
//    func connect(with view: UIView) {
//        let name = String(describing: self)
//        _ = UINib(nibName: name, bundle: Bundle(for: type(of: self))).instantiate(withOwner: self)
//        view.addSubview(self)
//        self.frame = view.bounds
//        self.autoresizingMask = [.flexibleHeight, .flexibleWidth]
//    }
    
}
