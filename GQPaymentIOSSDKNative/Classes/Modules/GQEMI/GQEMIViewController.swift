//
//  GQEMIViewController.swift
//  TestCases_Example
//
//  Created by valentine on 15/02/24.
//

import UIKit

class GQEMIViewController: GQBaseViewController {
    
    //IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    //Variables
    private var viewModel: (any GQEMIViewModelType)?
    private var boxSize: CGSize!
    
    init(viewModel: some GQEMIViewModelType) {
        super.init(nibName: "GQEMIViewController", bundle: Bundle(for: type(of: self)))
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        overrideUserInterfaceStyle = .light
        self.view.backgroundColor = .white
        
        setupCollectionView()
    }

    private func setupCollectionView() {
        collectionView.bounces = false
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let emiCell = UINib(nibName: "EMIApplicationCollectionViewCell", bundle: nil)
        collectionView.register(emiCell, forCellWithReuseIdentifier: "EMIApplicationCollectionViewCell")
        
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
//            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            flowLayout.minimumLineSpacing = 28
            flowLayout.minimumInteritemSpacing = 28
        }
        
        collectionView.contentInset = UIEdgeInsets(top: 15, left: 0, bottom: 15, right: 0)
        calculateBoxSize()
    }
    
    private func calculateBoxSize() {
        let side: CGFloat = min(collectionView.frame.width, collectionView.frame.height) * 0.8
        self.boxSize = CGSize(width: side, height: side)
    }

}

extension GQEMIViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.numberOfItems ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EMIApplicationCollectionViewCell", for: indexPath) as! EMIApplicationCollectionViewCell
        let data = viewModel?.getItem(at: indexPath.item)
        cell.configure(with: data, delegate: self)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return boxSize
    }
}

extension GQEMIViewController: EMIApplicationButtonDelegate {
    func didTapActionButton() {
//        guard let item = viewModel?.getItem(at: ) else { return }
    }
    
    
}
