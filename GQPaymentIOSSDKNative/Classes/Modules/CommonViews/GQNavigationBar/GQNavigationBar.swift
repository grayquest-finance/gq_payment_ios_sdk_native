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
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupView() {
        self.loadNib()
        contentView.combine(with: self)
    }
    
    private func setupUI() {
        self.contentView.backgroundColor = GQPayment.themeColor
    }

}
