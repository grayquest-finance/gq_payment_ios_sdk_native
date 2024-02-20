//
//  GQIssueFiiterView.swift
//  GQPaymentIOSSDKNative
//
//  Created by valentine on 20/02/24.
//

import UIKit

class GQSupportFooterView: UIView {
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var actionButton: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        _ = UINib(nibName: "GQSupportFooterView", bundle: Bundle(for: type(of: self))).instantiate(withOwner: self)
        self.addSubview(contentView)
        self.contentView.frame = self.bounds
        self.contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        self.backgroundColor = .gray807E8D.withAlphaComponent(0.4)
        
        titleLabel.textColor = .gray807E8D
        titleLabel.font = .systemFont(ofSize: 18, weight: .medium)
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.textAlignment = .left
        
        descriptionLabel.textColor = .gray807E8D
        descriptionLabel.font = .systemFont(ofSize: 18, weight: .regular)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.textAlignment = .left
        
        actionButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        actionButton.backgroundColor = .clear
        actionButton.contentMode = .left
        actionButton.titleLabel?.textAlignment = .left
        actionButton.tintColor = .blue4029CC
        
        titleLabel.text = "Facing issues?"
        descriptionLabel.text = "Our customer support team is here to help you. In case you have any query"
        actionButton.setTitle("CONTACT US >>>", for: .normal)
    }

}
