//
//  EnterMobileNumberViewController.swift
//  TestCases_Example
//
//  Created by valentine on 16/02/24.
//

import UIKit

class EnterMobileNumberViewController: GQBaseViewController {
    
//   MARK: IBOutlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var gileView: GQGILEView!

    @IBOutlet weak var supportFooterView: GQSupportFooterView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    
    
//  MARK: Variables
    private var viewModel: (any EnterMobileNumberViewModelType)?
    
    init(viewModel: some EnterMobileNumberViewModelType) {
        super.init(nibName: "EnterMobileNumberViewController", bundle: Bundle(for: type(of: self)))
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        adjustScrollViewForKeyboard(scrollView: scrollView)
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI()
    }
    
    public func configureUI() {
        Task {
            await gileView.configure(with: "")
        }
    }

    private func setupUI() {
        overrideUserInterfaceStyle = .light
        
        setupLabels()
    }
    
    private func setupLabels() {
        titleLabel.textColor = .black
        titleLabel.font = .customFont(.poppins, weight: .regular, size: 18)
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.textAlignment = .left
        
        noteLabel.textColor = .black
        noteLabel.font = .customFont(.dmSans, weight: .regular, size: 14)
        noteLabel.numberOfLines = 0
        noteLabel.lineBreakMode = .byWordWrapping
        noteLabel.textAlignment = .left
        
        titleLabel.text = "Enter your Mobile Number"
        
        let noteTitle = NSAttributedString(string: "NOTE: ",
                                      font: .customFont(.dmSans, weight: .bold, size: 14),
                                      color: .green40850A)
        let noteDescription = NSAttributedString(string: "Please enter the mobile number which you generally use for your banking purposes.",
                                                 font: .customFont(.dmSans, weight: .regular, size: 14),
                                                 color: .gray4D4B5A)
        noteLabel.attributedText = noteTitle.addAttributedString(noteDescription)
    }
}
