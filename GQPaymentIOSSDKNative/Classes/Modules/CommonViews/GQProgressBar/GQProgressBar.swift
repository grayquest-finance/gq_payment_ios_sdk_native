//
//  GQProgressBar.swift
//  GQPaymentIOSSDKNative
//
//  Created by valentine on 22/03/24.
//

import UIKit

class GQProgressBar: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var progressContainerView: UIView!
    
    @IBOutlet weak var checkpointStackView: UIStackView!
    
    @IBOutlet weak var progressTitleLabel: UILabel!
    @IBOutlet weak var checkpointOneTitle: UILabel!
    @IBOutlet weak var checkpointTwoTitle: UILabel!
    @IBOutlet weak var checkpointThreeTitle: UILabel!
    @IBOutlet weak var checkpointOneDescription: UILabel!
    @IBOutlet weak var checkpointTwoDescription: UILabel!
    @IBOutlet weak var checkpointThreeDescription: UILabel!
    
    @IBOutlet weak var checkpointOneIcon: UIImageView!
    @IBOutlet weak var checkpointTwoIcon: UIImageView!
    @IBOutlet weak var checkpointThreeIcon: UIImageView!
    
    @IBOutlet weak var progressView: GQProgressView!
    
    internal var progress: Float {
        return progressView.progress
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
        setupProgressView()
        setupIcons()
        setupLabels()
        setupStaticText()
    }
    
    private func setupProgressView() {
        progressView.trackTintColor = .grayDFDFE3
        progressView.tintColor = .green40850A
    }
    
    private func setupLabels() {
        progressTitleLabel.textColor = .black26262D
        progressTitleLabel.font = .customFont(.poppins, weight: .medium, size: 18)
        progressTitleLabel.numberOfLines = 1
        progressTitleLabel.lineBreakMode = .byWordWrapping
        progressTitleLabel.textAlignment = .left
        
        checkpointOneTitle.textColor = .black26262D
        checkpointOneTitle.font = .customFont(.dmSans, weight: .medium, size: 10)
        checkpointOneTitle.numberOfLines = 1
        checkpointOneTitle.lineBreakMode = .byWordWrapping
        checkpointOneTitle.textAlignment = .center
        
        checkpointTwoTitle.textColor = .black26262D
        checkpointTwoTitle.font = .customFont(.dmSans, weight: .medium, size: 10)
        checkpointTwoTitle.numberOfLines = 1
        checkpointTwoTitle.lineBreakMode = .byWordWrapping
        checkpointTwoTitle.textAlignment = .center
        
        checkpointThreeTitle.textColor = .black26262D
        checkpointThreeTitle.font = .customFont(.dmSans, weight: .medium, size: 10)
        checkpointThreeTitle.numberOfLines = 1
        checkpointThreeTitle.lineBreakMode = .byWordWrapping
        checkpointThreeTitle.textAlignment = .center
        
        checkpointOneDescription.textColor = .black26262D
        checkpointOneDescription.font = .customFont(.dmSans, weight: .medium, size: 10)
        checkpointOneDescription.numberOfLines = 2
        checkpointOneDescription.lineBreakMode = .byWordWrapping
        checkpointOneDescription.textAlignment = .center
        
        checkpointTwoDescription.textColor = .black26262D
        checkpointTwoDescription.font = .customFont(.dmSans, weight: .medium, size: 10)
        checkpointTwoDescription.numberOfLines = 2
        checkpointTwoDescription.lineBreakMode = .byWordWrapping
        checkpointTwoDescription.textAlignment = .center
        
        checkpointThreeDescription.textColor = .black26262D
        checkpointThreeDescription.font = .customFont(.dmSans, weight: .medium, size: 10)
        checkpointThreeDescription.numberOfLines = 2
        checkpointThreeDescription.lineBreakMode = .byWordWrapping
        checkpointThreeDescription.textAlignment = .center
    }
    
    private func setupStaticText() {
        progressTitleLabel.text = GQStaticText.yourProgress
        checkpointOneDescription.text = GQStaticText.fillBasicForm
        checkpointTwoDescription.text = GQStaticText.acceptTermsnConditions
        checkpointThreeDescription.text = GQStaticText.feePaidToInstitute
        checkpointOneTitle.text = "1"
        checkpointTwoTitle.text = "2"
        checkpointThreeTitle.text = "3"
    }
    
    private func setupIcons() {
        checkpointOneIcon.image = .getImage(icon: .incompleteCheckpointIcon)
        checkpointTwoIcon.image = .getImage(icon: .incompleteCheckpointIcon)
        checkpointThreeIcon.image = .getImage(icon: .incompleteCheckpointIcon)
    }
    
    @MainActor internal func set(progress: Float) {
        progressView.setProgress(progress, animated: true)
        adjustProgressState()
    }
    
    @MainActor private func adjustProgressState() {
        let firstCheckpoint = progressContainerView.convert(checkpointOneIcon.frame, from: checkpointStackView).midX / progressView.frame.width
        let secondCheckpoint = progressContainerView.convert(checkpointTwoIcon.frame, from: checkpointStackView).midX / progressView.frame.width
        let thirdCheckpoint = progressContainerView.convert(checkpointThreeIcon.frame, from: checkpointStackView).midX / progressView.frame.width
        
        if self.progress >= Float(firstCheckpoint) {
            checkpointOneIcon.image = .getImage(icon: .completeCheckpointIcon)
        }
        
        if self.progress >= Float(secondCheckpoint) {
            checkpointTwoIcon.image = .getImage(icon: .completeCheckpointIcon)
        }
        
        if self.progress >= Float(thirdCheckpoint) {
            checkpointThreeIcon.image = .getImage(icon: .completeCheckpointIcon)
        }
    }
    
}
