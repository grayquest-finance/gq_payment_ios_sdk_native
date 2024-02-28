//
//  GQIssueFiiterView.swift
//  GQPaymentIOSSDKNative
//
//  Created by valentine on 20/02/24.
//

import UIKit

protocol GQSupportFooterViewDelegate {
    func footerViewDidClickOpenWindow(_ footerView: GQSupportFooterView)
}

class GQSupportFooterView: UIView {
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var supportImageview: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var openWindowButton: UIButton!
    
    public var delegate: (any GQSupportFooterViewDelegate)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        self.loadNib()
        contentView.combine(with: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        self.contentView.backgroundColor = .whiteF5F5F5
        
        titleLabel.textColor = .purple63499D
        titleLabel.font = .customFont(.poppins, weight: .medium, size: 18)
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.textAlignment = .left
        
        descriptionLabel.textColor = .gray4D4B5A
        descriptionLabel.font = .customFont(.dmSans, weight: .regular, size: 14)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.textAlignment = .left
        
        setupIcons()
        
        titleLabel.text = "Facing issues here?"
        descriptionLabel.text = "Please contact our support team by clicking here"
    }
    
    private func setupIcons() {
        supportImageview.image = .getImage(icon: .supportIcon)
        supportImageview.contentMode = .scaleAspectFit
        
        openWindowButton.setImage(.getImage(icon: .newWindowIcon), for: .normal)
        openWindowButton.contentMode = .scaleAspectFit
    }
    
    @IBAction func clickedOpenWindowAction(_ sender: UIButton) {
        delegate?.footerViewDidClickOpenWindow(self)
    }
    
}
