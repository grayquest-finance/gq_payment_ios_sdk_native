//
//  GQProgressView.swift
//  GQPaymentIOSSDKNative
//
//  Created by valentine on 26/03/24.
//

import UIKit

class GQProgressView: UIProgressView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.set(cornerRadius: self.frame.height * 0.3)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.set(cornerRadius: self.frame.height * 0.3)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.subviews.forEach {
            $0.layer.masksToBounds = true
            $0.layer.cornerRadius = $0.bounds.height * 0.5
        }
    }
    
}
