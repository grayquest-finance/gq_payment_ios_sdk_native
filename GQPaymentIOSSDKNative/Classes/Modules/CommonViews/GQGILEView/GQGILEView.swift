//
//  GQGILEView.swift
//  GQPaymentIOSSDKNative
//
//  Created by valentine on 20/02/24.
//

import UIKit

class GQGILEView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var gileImageView: UIImageView!
    @IBOutlet weak var gileTitleLabel: UILabel!
    
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
        self.backgroundColor = .clear
        contentView.set(cornerRadius: 0.06)
        contentView.backgroundColor = GQPaymentSDK.themeColor
        
        gileTitleLabel.textColor = .white
        gileTitleLabel.font = .customFont(.dmSans, weight: .regular, size: 16)
        gileTitleLabel.numberOfLines = 0
        gileTitleLabel.lineBreakMode = .byWordWrapping
        gileTitleLabel.textAlignment = .left
        
        gileImageView.image = .getImage(icon: .grayQuestIcon)
        gileImageView.contentMode = .scaleAspectFit
        gileImageView.set(cornerRadius: 0.1)
    }
    
    @MainActor public func configure(with data: String?) async {
        guard let data else { return }
        gileImageView.image = .getImage(icon: .grayQuestIcon)
        gileTitleLabel.text = data
    }
    
}
