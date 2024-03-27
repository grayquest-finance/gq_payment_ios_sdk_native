//
//  GQInformationView.swift
//  GQPaymentIOSSDKNative
//
//  Created by valentine on 26/03/24.
//

import UIKit

class GQInformationView: UIView {
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var informationImageView: UIImageView!
    
    @IBOutlet weak var informationDescriptionLabel: UILabel!
    
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
        contentView.backgroundColor = .whiteF5F5F5
        contentView.set(cornerRadius: 0.01)
        
        informationImageView.image = .getImage(icon: .informationIcon)
        
        informationDescriptionLabel.textColor = .black26262D
        informationDescriptionLabel.font = .customFont(.dmSans, weight: .regular, size: 16)
        informationDescriptionLabel.numberOfLines = 0
        informationDescriptionLabel.lineBreakMode = .byWordWrapping
        informationDescriptionLabel.textAlignment = .left
        
        informationDescriptionLabel.text = "To sign up for monthly payment plan, we require you to enter the details of the primary earning member of your family."
    }
    
}
