//
//  GQCheckBox.swift
//  GQPaymentIOSSDKNative
//
//  Created by valentine on 27/03/24.
//

import UIKit

class GQConsentView: UIView {
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var button: UIButton!
    
    @IBOutlet weak var consentLabel: UILabel!
    
    public var isSelected: Bool {
        return button.isSelected
    }
    
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
        contentView.backgroundColor = .white
        
        button.setImage(.getImage(icon: .checkbox), for: .normal)
        button.setImage(.getImage(icon: .grayQuestIcon), for: .selected)
        
        consentLabel.textColor = .black26262D
        consentLabel.font = .customFont(.dmSans, weight: .medium, size: 12)
        consentLabel.numberOfLines = 0
        consentLabel.lineBreakMode = .byWordWrapping
        consentLabel.textAlignment = .left
        
        consentLabel.text = "By proceeding, you allow Grayquest / affiliate banking partners to fetch details from our partner bureau. Be assured as your credit score will not be impacted by this."
    }
    
    @IBAction func didClickCheckBox(_ sender: UIButton) {
        Task { @MainActor in
            sender.isSelected.toggle()
        }
    }
    
}
