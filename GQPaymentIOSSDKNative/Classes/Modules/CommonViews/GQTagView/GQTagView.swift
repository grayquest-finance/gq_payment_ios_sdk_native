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
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        //Adding View
        UINib(nibName: "GQTagView", bundle: Bundle(for: type(of: self))).instantiate(withOwner: self)
        self.addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        //Setting up UI
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
