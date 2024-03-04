//
//  VerifyOTPViewController.swift
//  TestCases_Example
//
//  Created by valentine on 16/02/24.
//

import UIKit

class VerifyOTPViewController: GQBaseViewController {

    //MARK: IBOutlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mobileOTPView: MobileOTPView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var mobileNumberLabel: UILabel!
    @IBOutlet weak var resendOTPLabel: UILabel!
    @IBOutlet weak var changeMobileNumberLabel: UILabel!
    
    @IBOutlet weak var verifyOTPButton: UIButton!
    
    
    //MARK: Variables
    private var viewModel: (any VerifyOTPViewModelType)?
    
    init(viewModel: some VerifyOTPViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: "VerifyOTPViewController", bundle: Bundle(for: type(of: self)))
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
        
    }
    
    private func setupUI() {
        overrideUserInterfaceStyle = .light
        
        setupLabels()
        setupButtons()
    }

    private func setupLabels() {
        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: 24, weight: .black)
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.textAlignment = .center
        
        subTitleLabel.textColor = .darkGray
        subTitleLabel.font = .systemFont(ofSize: 16, weight: .medium)
        subTitleLabel.numberOfLines = 0
        subTitleLabel.lineBreakMode = .byWordWrapping
        subTitleLabel.textAlignment = .center
        
        mobileNumberLabel.textColor = .black
        mobileNumberLabel.font = .systemFont(ofSize: 18, weight: .black)
        mobileNumberLabel.numberOfLines = 0
        mobileNumberLabel.lineBreakMode = .byWordWrapping
        mobileNumberLabel.textAlignment = .center
        
        resendOTPLabel.textColor = .darkGray
        resendOTPLabel.font = .systemFont(ofSize: 16, weight: .medium)
        resendOTPLabel.numberOfLines = 0
        resendOTPLabel.lineBreakMode = .byWordWrapping
        resendOTPLabel.textAlignment = .center
        
        changeMobileNumberLabel.textColor = .darkGray
        changeMobileNumberLabel.font = .systemFont(ofSize: 16, weight: .medium)
        changeMobileNumberLabel.numberOfLines = 0
        changeMobileNumberLabel.lineBreakMode = .byWordWrapping
        changeMobileNumberLabel.textAlignment = .center
        
        titleLabel.text = "OTP Verification"
        subTitleLabel.text = "Enter the 4 digit OTP (One Time Password) sent on your mobile number"
        mobileNumberLabel.text = "+91-8456666666"
        
        // Resend OTP and Mobile Number Labels need attributed text
        resendOTPLabel.text = "Did not receive OTP? Resend"
        changeMobileNumberLabel.text = "Entered mobile number is wrong? Change Mobile Number"
    }
    
    private func setupButtons() {
        verifyOTPButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        verifyOTPButton.backgroundColor = GQPayment.themeColor
        verifyOTPButton.tintColor = .white
        verifyOTPButton.setTitle("Send OTP", for: .normal)
        verifyOTPButton.set(cornerRadius: 0.2)
    }
    
    @IBAction func clickedVerifyOTPButton(_ sender: UIButton) {
        
        if mobileOTPView.isCompleted {
            Task { @MainActor in
                let paymentMethodsVM = PaymentMethodsViewModel()
                let paymentMethodsVC = PaymentMethodsViewController(viewModel: paymentMethodsVM)
                self.navigationController?.pushViewController(paymentMethodsVC, animated: true)
            }
            
        } else {
            GQLogger.shared.alert("Please complete OTP incorret or Invalid!!!")
        }
        
    }
    
}
