//
//  NSAttributedString+Ext.swift
//  GQPaymentIOSSDKNative
//
//  Created by valentine on 22/02/24.
//

import UIKit

extension NSAttributedString {
    
    convenience init(string: String, font: UIFont?, color: UIColor) {
        let font = font ?? .systemFont(ofSize: 15, weight: .regular)
        self.init(string: string,
                  attributes: [.font: font,
                               .foregroundColor: color])
    }
    
    func addAttributedString(_ attributedString: NSAttributedString) -> NSMutableAttributedString {
        let text = NSMutableAttributedString(attributedString: self)
        text.append(attributedString)
        return text
    }
}
