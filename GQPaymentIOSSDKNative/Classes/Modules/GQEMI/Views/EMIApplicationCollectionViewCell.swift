//
//  EMIApplicationCollectionViewCell.swift
//  TestCases_Example
//
//  Created by valentine on 15/02/24.
//

import UIKit

protocol EMIApplicationButtonDelegate {
    func didTapActionButton()
}

class EMIApplicationCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var tagView: GQTagView!
    
    @IBOutlet weak var applicationIDNameLabel: UILabel!
    @IBOutlet weak var applicationIDValueLabel: UILabel!
    @IBOutlet weak var createdOnLabel: UILabel!
    @IBOutlet weak var feeAmountNameLabel: UILabel!
    @IBOutlet weak var feeAmountValueLabel: UILabel!
    @IBOutlet weak var studentNameLabel: UILabel!
    @IBOutlet weak var academicYearLabel: UILabel!
    
    @IBOutlet weak var actionButton: UIButton!
    
    var delegate: (any EMIApplicationButtonDelegate)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        self.contentView.set(cornerRadius: 0.03, borderWidth: 1, borderColor: .lightGray)
        self.contentView.backgroundColor = .white
        
        setupLabels()
        setupButtons()
    }
    
    private func setupLabels() {
        applicationIDNameLabel.textColor = .darkGray
        applicationIDNameLabel.textAlignment = .left
        applicationIDNameLabel.numberOfLines = 1
        applicationIDNameLabel.font = .systemFont(ofSize: 16, weight: .medium)
        applicationIDNameLabel.text = "Application ID:"
        
        applicationIDValueLabel.textColor = .black
        applicationIDValueLabel.textAlignment = .left
        applicationIDValueLabel.numberOfLines = 1
        applicationIDValueLabel.font = .systemFont(ofSize: 20, weight: .black)
        
        createdOnLabel.textColor = .darkGray
        createdOnLabel.textAlignment = .left
        createdOnLabel.numberOfLines = 1
        createdOnLabel.font = .systemFont(ofSize: 16, weight: .medium)
        
        feeAmountNameLabel.textColor = .darkGray
        feeAmountNameLabel.textAlignment = .left
        feeAmountNameLabel.numberOfLines = 1
        feeAmountNameLabel.font = .systemFont(ofSize: 16, weight: .medium)
        feeAmountNameLabel.text = "Fee Amount:"
        
        feeAmountValueLabel.textColor = .black
        feeAmountValueLabel.textAlignment = .left
        feeAmountValueLabel.numberOfLines = 1
        feeAmountValueLabel.font = .systemFont(ofSize: 20, weight: .black)
        
        studentNameLabel.textColor = .darkGray
        studentNameLabel.textAlignment = .left
        studentNameLabel.numberOfLines = 1
        studentNameLabel.font = .systemFont(ofSize: 16, weight: .medium)
        
        academicYearLabel.textColor = .darkGray
        academicYearLabel.textAlignment = .left
        academicYearLabel.numberOfLines = 1
        academicYearLabel.font = .systemFont(ofSize: 16, weight: .medium)
    }
    
    private func setupButtons() {
        actionButton.backgroundColor = .systemIndigo
        actionButton.tintColor = .white
        actionButton.set(cornerRadius: 0.2)
    }
    
    @IBAction func clickedActionButton(_ sender: UIButton) {
        delegate?.didTapActionButton()
    }
    
    public func configure(with data: String?, delegate: some EMIApplicationButtonDelegate) {
        guard let data else { return }
        self.delegate = delegate
        
        applicationIDValueLabel.text = "344586"
        createdOnLabel.text = "Created On: \("06/02/2024")"
        feeAmountValueLabel.text = "1,20,000"
        studentNameLabel.text = "Student Name: \("abcde fghijk")"
        academicYearLabel.text = "Academic Year: \("2022 - 2023")"
        
        tagView.configure(with: "Decision Pending")
    }
    
}
