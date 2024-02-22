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
        _ = UINib(nibName: "GQGILEView", bundle: GQPayment.bundle).instantiate(withOwner: self)
        self.addSubview(contentView)
        self.contentView.frame = self.bounds
        self.contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        self.backgroundColor = .clear
        contentView.set(cornerRadius: 0.07)
        contentView.backgroundColor = .red991F2C
        
        gileTitleLabel.textColor = .white
        gileTitleLabel.font = .customFont(.dmSans, weight: .regular, size: 16)
        gileTitleLabel.numberOfLines = 0
        gileTitleLabel.lineBreakMode = .byWordWrapping
        gileTitleLabel.textAlignment = .left
    }
    
    @MainActor public func configure(with data: String?) async {
        guard let data else { return }
//        gileImageView.image = UIImage(named: "closeIcon")
        gileTitleLabel.text = "GITAM Institute of Management, Mumbai, CBSE"
    }
    
}
