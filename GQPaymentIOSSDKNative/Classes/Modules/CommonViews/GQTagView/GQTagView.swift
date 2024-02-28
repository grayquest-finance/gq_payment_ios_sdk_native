//
//  GQTagView.swift
//  TestCases_Example
//
//  Created by valentine on 15/02/24.
//

import UIKit

class GQTagView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var tagName: UILabel!

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
        self.contentView.backgroundColor = .clear
        setupTagName()
    }
    
    private func setupTagName() {
        tagName.textColor = .systemIndigo
        tagName.set(cornerRadius: contentView.frame.height, borderWidth: 1, borderColor: .systemIndigo)
        tagName.font = .systemFont(ofSize: 14, weight: .bold)
        tagName.textAlignment = .center
        tagName.numberOfLines = 1
    }
    
    public func configure(with title: String?) {
        guard let title else { return }
        
        Task { @MainActor in
            self.tagName.text = title
        }
    }

}
