//
//  GQNavigationBar.swift
//  TestCases_Example
//
//  Created by valentine on 16/02/24.
//

import UIKit

class GQNavigationBar: UINavigationBar {
    
    @IBOutlet var contentView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        UINib(nibName: "GQNavigationBar", bundle: Bundle(for: type(of: self))).instantiate(withOwner: self)
        self.addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.contentView.backgroundColor = GQPayment.themeColor
    }

}
