//
//  PaymentMethodsCollectionViewCell.swift
//  TestCases_Example
//
//  Created by valentine on 13/02/24.
//

import UIKit

class PaymentMethodsCollectionViewCell: UICollectionViewCell {
    
    //IBOutlets
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var paymentPriceView: UIView!
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var priceTitle: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var paymentStartDate: UILabel!
    @IBOutlet weak var optionNumber: UILabel!
    
    @IBOutlet weak var selectionImageView: UIImageView!
    @IBOutlet weak var startDateImageView: UIImageView!
    
    @IBOutlet weak var tagsCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        contentView.layoutIfNeeded()
        let size = contentView.systemLayoutSizeFitting(
            CGSize(width: targetSize.width, height: UIView.layoutFittingCompressedSize.height),
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel)
        return size
    }
    
    private func setupUI() {
        self.innerView.set(cornerRadius: 0.08, borderWidth: 1, borderColor: .lightGray)
        setupLabels()
        setupOptionLabel()
        setupPaymentPriceView()
        setupTagsCollectionView()
    }
    
    private func setupLabels() {
        self.title.font = .systemFont(ofSize: 20, weight: .medium)
        self.title.textColor = .black
        self.title.numberOfLines = 0
        self.title.lineBreakMode = .byWordWrapping
        
        self.subtitle.font = .systemFont(ofSize: 18, weight: .medium)
        self.subtitle.textColor = .darkGray
        self.subtitle.numberOfLines = 0
        self.subtitle.lineBreakMode = .byWordWrapping
        
        self.priceTitle.font = .systemFont(ofSize: 18, weight: .medium)
        self.priceTitle.textColor = .darkGray
        
        self.price.font = .systemFont(ofSize: 30, weight: .black)
        self.price.textColor = .black
        
        self.paymentStartDate.font = .systemFont(ofSize: 14, weight: .regular)
        self.paymentStartDate.textColor = .darkGray
    }
    
    private func setupTagsCollectionView() {
        tagsCollectionView.backgroundColor = .clear
        tagsCollectionView.dataSource = self
        tagsCollectionView.delegate = self
        
        tagsCollectionView.isScrollEnabled = false
        let nib = UINib(nibName: "PaymentTagCollectionViewCell", bundle: nil)
        tagsCollectionView.register(nib, forCellWithReuseIdentifier: "PaymentTagCollectionViewCell")
        
        if let flowLayout = tagsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            flowLayout.minimumLineSpacing = 5
            flowLayout.minimumInteritemSpacing = 5
        }
    
    }
    
    private func setupPaymentPriceView() {
        DispatchQueue.main.async {
            self.paymentPriceView.backgroundColor = .lightGray.withAlphaComponent(0.2)
            self.paymentPriceView.set(cornerRadius: 0.08, borderWidth: 1, borderColor: .lightGray)
        }
    }
    
    private func setupOptionLabel() {
        DispatchQueue.main.async {
            self.optionNumber.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.9)
            self.optionNumber.set(cornerRadius: 0.2)
        }
//        self.optionNumber.safeAreaInsets = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
    }
    
    public func configure(with data: String?, isSelected: Bool) {
        guard let data else { return }
        DispatchQueue.main.async {
            self.tagsCollectionView.reloadData()
            self.optionNumber.text = "Option \(data)"
        }
        if isSelected {
            self.selected()
        } else {
            self.deselected()
        }
    }
    
    public func selected() {
        DispatchQueue.main.async {
            self.innerView.backgroundColor = .systemBlue.withAlphaComponent(0.1)
            self.innerView.layer.borderColor = UIColor.systemBlue.cgColor
        }
    }
    
    public func deselected() {
        DispatchQueue.main.async {
            self.innerView.backgroundColor = .white
            self.innerView.layer.borderColor = UIColor.lightGray.cgColor
        }
    }

}

//UICollectionViewDataSource
extension PaymentMethodsCollectionViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PaymentTagCollectionViewCell", for: indexPath) as! PaymentTagCollectionViewCell
//        let data = viewModel?.getItem(at: indexPath.item)
        if indexPath.item % 2 == 0 {
            cell.configure(with: "easy and convenient")
        } else {
            cell.configure(with: "easy")
        }
//        cell.configure(with: "easy and convenient")
        return cell
    }
 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: collectionView.frame.height)
    }
    
}
