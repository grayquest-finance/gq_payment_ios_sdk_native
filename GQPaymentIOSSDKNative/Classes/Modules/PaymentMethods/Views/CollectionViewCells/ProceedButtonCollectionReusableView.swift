//
//  ProceedButtonCollectionReusableView.swift
//  TestCases_Example
//
//  Created by valentine on 15/02/24.
//

import UIKit

protocol ProceedButtonDelegate {
    func didTapProceed()
}

class ProceedButtonCollectionReusableView: UICollectionReusableView {
    
    //IBOutlets
    @IBOutlet weak var proceedButton: UIButton!
    
    private var delegate: (any ProceedButtonDelegate)?

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        proceedButton.backgroundColor = .systemBlue
        proceedButton.tintColor = .white
        proceedButton.set(cornerRadius: 0.2)
//        proceedButton.isEnabled = false
    }
    
    @IBAction func clickedProceedButton(_ sender: UIButton) {
        delegate?.didTapProceed()
    }
    
    public func setEnabled() {
        proceedButton.isEnabled = true
    }
    
    public func configure(canProceed: Bool, delegate: some ProceedButtonDelegate) {
        proceedButton.isEnabled = canProceed
        self.delegate = delegate
        
    }
}
