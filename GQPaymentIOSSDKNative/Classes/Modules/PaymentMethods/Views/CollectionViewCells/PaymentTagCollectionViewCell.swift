//
//  PaymentTagCollectionViewCell.swift
//  TestCases_Example
//
//  Created by valentine on 13/02/24.
//

import UIKit

class PaymentTagCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var tagName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        contentView.layoutIfNeeded()
        let size = contentView.systemLayoutSizeFitting(
            CGSize(width: UIView.layoutFittingCompressedSize.width, height: targetSize.height),
            withHorizontalFittingPriority: .fittingSizeLevel,
            verticalFittingPriority: .required)
        return size
    }
    
    private func setupUI() {
        self.contentView.backgroundColor = .systemOrange.withAlphaComponent(0.2)
        self.contentView.set(cornerRadius: 0.2)
        
        self.tagName.font = .systemFont(ofSize: 12, weight: .medium)
        self.tagName.numberOfLines = 1
        self.tagName.textColor = .black
        self.tagName.textAlignment = .center
    }
    
    public func configure(with data: String?) {
        guard let data else { return }
        DispatchQueue.main.async {
            self.tagName.text = data
        }
    }

}
