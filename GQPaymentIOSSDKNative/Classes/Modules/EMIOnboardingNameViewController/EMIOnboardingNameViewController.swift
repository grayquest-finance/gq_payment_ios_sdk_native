//
//  EMIOnboardingNameViewController.swift
//  GQPaymentIOSSDKNative
//
//  Created by valentine on 26/03/24.
//

import UIKit

class EMIOnboardingNameViewController: GQBaseViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var gileView: GQGILEView!
    
    @IBOutlet weak var supportFooterView: GQSupportFooterView!
    
    @IBOutlet weak var progressBar: GQProgressBar!
    
    
//  MARK: Variables
    private var viewModel: (any EMIOnboardingNameViewModelType)?
    weak var gqPaymentSDK: GQPaymentSDK?
    
    init(viewModel: some EMIOnboardingNameViewModelType) {
        super.init(nibName: "EMIOnboardingNameViewController", bundle: GQPaymentSDK.bundle)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        adjustScrollViewForKeyboard(scrollView: scrollView)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI()
    }
    
    private func setupUI() {
        
    }

    public func configureUI() {
        //Needs to be called after API call.
        Task {
            await gileView.configure(with: viewModel?.gile)
        }
    }
    
    
}
