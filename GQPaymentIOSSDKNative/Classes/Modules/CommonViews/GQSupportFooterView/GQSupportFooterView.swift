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
        _ = UINib(nibName: "GQSupportFooterView", bundle: GQPayment.bundle).instantiate(withOwner: self)
        self.addSubview(contentView)
        self.contentView.frame = self.bounds
        self.contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.backgroundColor = .clear
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        self.contentView.backgroundColor = .lightGray
        
        titleLabel.textColor = .gray807E8D
        titleLabel.font = .customFont(.poppins, weight: .medium, size: 20)
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.textAlignment = .left
        
        descriptionLabel.textColor = .gray807E8D
        descriptionLabel.font = .customFont(.dmSans, weight: .regular, size: 14)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.textAlignment = .left
        
        actionButton.titleLabel?.font = .customFont(.dmSans, weight: .bold, size: 14)
        actionButton.backgroundColor = .clear
        actionButton.contentMode = .left
        actionButton.titleLabel?.textAlignment = .left
        actionButton.tintColor = .blue4029CC
        
        titleLabel.text = "Facing issues?"
        descriptionLabel.text = "Our customer support team is here to help you. In case you have any query"
        actionButton.setTitle("CONTACT US >>>", for: .normal)
    }

}
