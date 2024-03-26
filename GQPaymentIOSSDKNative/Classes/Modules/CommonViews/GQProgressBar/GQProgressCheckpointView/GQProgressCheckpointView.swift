//
//  GQProgressCheckpointView.swift
//  GQPaymentIOSSDKNative
//
//  Created by valentine on 26/03/24.
//

import UIKit


class GQProgressCheckpointView: UIView {
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var checkpointStackView: UIStackView!
    
    @IBOutlet weak var checkpointIconImageView: UIImageView!
    
    @IBOutlet weak var checkpointNumberLabel: UILabel!
    @IBOutlet weak var checkpointDescriptionLabel: UILabel!
    
    internal var contentAlignment: NSTextAlignment = .center
    
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
        contentView.backgroundColor = .clear
        
//        checkpointIconImageView.image = .getImage(icon: .incompleteCheckpointIcon)
        
        checkpointNumberLabel.textColor = .black26262D
        checkpointNumberLabel.font = .customFont(.poppins, weight: .medium, size: 10)
        checkpointNumberLabel.numberOfLines = 1
        checkpointNumberLabel.lineBreakMode = .byWordWrapping
        checkpointNumberLabel.textAlignment = .center
        
        checkpointDescriptionLabel.textColor = .black26262D
        checkpointDescriptionLabel.font = .customFont(.poppins, weight: .medium, size: 10)
        checkpointDescriptionLabel.numberOfLines = 0
        checkpointDescriptionLabel.lineBreakMode = .byWordWrapping
//        checkpointDescriptionLabel.textAlignment = .center
    }
    
    @MainActor public func configure(alignment: NSTextAlignment = .center) {
        switch alignment {
        case .center:
            checkpointStackView.alignment = .center
        case .right:
            checkpointStackView.alignment = .trailing
        default:
            checkpointStackView.alignment = .leading
        }
        checkpointDescriptionLabel.textAlignment = .center
    }
    
    @MainActor public func configure(number: String, description: String, completed: Bool = false, alignment: NSTextAlignment = .center) {
        checkpointIconImageView.image = .getImage(icon: completed ? .completeCheckpointIcon : .incompleteCheckpointIcon)
        checkpointNumberLabel.text = number
        checkpointDescriptionLabel.text = description
        configure(alignment: alignment)
    }
    
}
