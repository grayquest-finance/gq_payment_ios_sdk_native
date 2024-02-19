//
//  PaymentMethodsViewController.swift
//  TestCases_Example
//
//  Created by valentine on 13/02/24.
//

import UIKit

class PaymentMethodsViewController: GQBaseViewController {
    
    //IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var scrollButton: UIButton!
    
    //Variables
    private var viewModel: (any PaymentMethodsViewModelType)?
    private var footer: ProceedButtonCollectionReusableView?
    
    init(viewModel: PaymentMethodsViewModelType) {
        super.init(nibName: "PaymentMethodsViewController", bundle: Bundle(for: type(of: self)))
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupServices()
    }

    private func setupUI() {
        overrideUserInterfaceStyle = .light
        self.view.backgroundColor = .white
        setupCollectionView()
        setupScrollButton()
    }
    
    private func setupServices() {
        viewModel?.fetchItems()
        collectionView.reloadData()
    }
    
    private func setupScrollButton() {
        scrollButton.set(cornerRadius: 0.5)
        scrollButton.backgroundColor = .systemBlue.withAlphaComponent(0.4)
        scrollButton.tintColor = .black.withAlphaComponent(0.5)
        
        scrollButton.setImage(UIImage(systemName: "arrowshape.down.fill"), for: .normal)
        scrollButton.setImage(UIImage(systemName: "arrowshape.up.fill"), for: .selected)
    }

    private func setupCollectionView() {
        collectionView.bounces = false
    
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.allowsMultipleSelection = false
        
        let paymentMethodsNib = UINib(nibName: "PaymentMethodsCollectionViewCell", bundle: nil)
        collectionView.register(paymentMethodsNib, forCellWithReuseIdentifier: "PaymentMethodsCollectionViewCell")
        
        let footerNib = UINib(nibName: "ProceedButtonCollectionReusableView", bundle: nil)
        collectionView.register(footerNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "ProceedButtonCollectionReusableView")
        
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            flowLayout.minimumLineSpacing = 12
        }
        
    }
    
    @IBAction func clickedScrollButton(_ sender: UIButton) {
        scrollButton.isSelected.toggle()
        
        DispatchQueue.main.async {
            if self.scrollButton.isSelected, let items = self.viewModel?.lastIndex {
                self.collectionView.scrollToItem(at: IndexPath(item: items, section: 0), at: .bottom, animated: true)
            } else {
                self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
            }
        }
    }
    

}

extension PaymentMethodsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.numberOfItems ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PaymentMethodsCollectionViewCell", for: indexPath) as! PaymentMethodsCollectionViewCell
        let data = viewModel?.getItem(at: indexPath.item)
        cell.configure(with: data, isSelected: viewModel?.selectedIndex == indexPath.item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let index = viewModel?.selectedIndex {
            DispatchQueue.main.async {
            let deselectIndexPath = IndexPath(item: index, section: .zero)
                if let cell = collectionView.cellForItem(at: deselectIndexPath) as? PaymentMethodsCollectionViewCell {
                    cell.deselected()
                }
            }
        }
        viewModel?.selectedIndex = indexPath.item
        DispatchQueue.main.async {
            if let cell = collectionView.cellForItem(at: indexPath) as? PaymentMethodsCollectionViewCell {
                cell.selected()
            }
            
            self.footer?.setEnabled()
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width * 0.9, height: 300)
    }
    
    //ADD SCROLLVIEW DELEGATES FOR SCHECKING IS USER SCROLLED UP OR DOWN
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionFooter:
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "ProceedButtonCollectionReusableView", for: indexPath) as! ProceedButtonCollectionReusableView
            footer.configure(canProceed: viewModel?.canProceed ?? false, delegate: self)
            self.footer = footer
            return footer
        default:
            break
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 60)
    }
    
}

extension PaymentMethodsViewController: ProceedButtonDelegate {
    func didTapProceed() {
        // ONLY EMI FLOW FOR NOW
        let emiViewModel = GQEMIViewModel()
        let emiViewController = GQEMIViewController(viewModel: emiViewModel)
        self.navigationController?.pushViewController(emiViewController, animated: true)
    }
    
    
}
