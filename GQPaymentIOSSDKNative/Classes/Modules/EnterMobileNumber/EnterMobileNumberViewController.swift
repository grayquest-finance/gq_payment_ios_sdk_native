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
        self.title = viewModel?.gile ?? ""
        
        Task {
            await gileView.configure(with: "")
        }
        
    }

    private func setupUI() {
        overrideUserInterfaceStyle = .light
        
        
    }
    
}
