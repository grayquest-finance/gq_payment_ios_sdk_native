//
//  EnterMobileNumberViewController.swift
//  TestCases_Example
//
//  Created by valentine on 16/02/24.
//

import UIKit

class EnterMobileNumberViewController: GQBaseViewController {
    
    //IBOutlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mobileNumberView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var mobileNumberCountryCode: UILabel!
    
    @IBOutlet weak var mobileNumberTextfield: UITextField!
    
    @IBOutlet weak var sendOTPButton: UIButton!
    
    //Variables
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
    }

    private func setupUI() {
        overrideUserInterfaceStyle = .light
        
        hideErrors()
        self.mobileNumberView.set(cornerRadius: 0.2, borderWidth: 1, borderColor: .lightGray)
        
        setupLabels()
        setupTextfields()
        setupButtons()
    }
    
    private func setupLabels() {
        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: 18, weight: .black)
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.textAlignment = .center
        
        subTitleLabel.textColor = .darkGray
        subTitleLabel.font = .systemFont(ofSize: 16, weight: .medium)
        subTitleLabel.numberOfLines = 0
        subTitleLabel.lineBreakMode = .byWordWrapping
        subTitleLabel.textAlignment = .center
        
        errorMessageLabel.textColor = .systemRed
        errorMessageLabel.font = .systemFont(ofSize: 16, weight: .medium)
        errorMessageLabel.numberOfLines = 0
        errorMessageLabel.lineBreakMode = .byWordWrapping
        errorMessageLabel.textAlignment = .left
        
        mobileNumberCountryCode.textColor = .black
        mobileNumberCountryCode.font = .systemFont(ofSize: 20, weight: .medium)
        mobileNumberCountryCode.numberOfLines = 1
        mobileNumberCountryCode.lineBreakMode = .byWordWrapping
        mobileNumberCountryCode.textAlignment = .center
        
        titleLabel.text = "Enter your Mobile Number to Proceed"
        subTitleLabel.text = "We will send you an OTP (One Time Password) on this mobile number."
        errorMessageLabel.text = "Please enter a mobile number"
        mobileNumberCountryCode.text = "+91 -"
    }
    
    private func setupButtons() {
        sendOTPButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        sendOTPButton.backgroundColor = GQPayment.themeColor
        sendOTPButton.tintColor = .white
        sendOTPButton.setTitle("Send OTP", for: .normal)
        sendOTPButton.set(cornerRadius: 0.2)
    }
    
    private func setupTextfields() {
        mobileNumberTextfield.borderStyle = .none
        mobileNumberTextfield.font = .systemFont(ofSize: 18, weight: .bold)
        mobileNumberTextfield.placeholder = "Mobile Number"
        mobileNumberTextfield.textColor = .black
    }
    
    @IBAction func clickedSendOTPButton(_ sender: UIButton) {
        guard let mobileNumber = mobileNumberTextfield.text, viewModel?.validate(mobileNumber: mobileNumber) ?? false else {
            displayError(message: "Please enter a mobile number")
            return
        }
        hideErrors()
        navigateToVerifyOTPViewController()
    }
    
    @MainActor func hideErrors() {
        self.errorMessageLabel.isHidden = true
    }
    
    @MainActor func displayError(message: String) {
        self.errorMessageLabel.text = message
        self.errorMessageLabel.isHidden = false
    }
    
    @MainActor func navigateToVerifyOTPViewController() {
        let verifyOTPViewModel = VerifyOTPViewModel()
        let verifyOTPViewController = VerifyOTPViewController(viewModel: verifyOTPViewModel)
        self.navigationController?.pushViewController(verifyOTPViewController, animated: true)
    }
}
