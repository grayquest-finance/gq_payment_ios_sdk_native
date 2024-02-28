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
        
    @IBOutlet weak var mobileTextField: GQMobileTextField!
    @IBOutlet weak var otpTextField: GQTextField!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var mobileNumberLabel: UILabel!
    @IBOutlet weak var resendOTPLabel: UILabel!

    @IBOutlet weak var verifyOTPButton: UIButton!
    
//  MARK: Variables
    private var viewModel: (any EnterMobileNumberViewModelType)?
    
    init(viewModel: some EnterMobileNumberViewModelType) {
        super.init(nibName: "EnterMobileNumberViewController", bundle: GQPayment.bundle)
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
        //Needs to be called after API call.
        Task {
            await gileView.configure(with: viewModel?.gile)
        }
    }

    private func setupUI() {
        overrideUserInterfaceStyle = .light
        
        setupLabels()
        mobileTextField.delegate = self
        
        otpTextField.delegate = self
        otpTextField.isTitleEnabled = false

        setOTPState(active: false)
    }
    
    private func setupLabels() {
        titleLabel.textColor = .black
        titleLabel.font = .customFont(.poppins, weight: .regular, size: 18)
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.textAlignment = .left
        
        noteLabel.textColor = .black4D4B5A
        noteLabel.font = .customFont(.dmSans, weight: .regular, size: 14)
        noteLabel.numberOfLines = 0
        noteLabel.lineBreakMode = .byWordWrapping
        noteLabel.textAlignment = .left
        
        resendOTPLabel.textColor = .gray4D4B5A
        resendOTPLabel.font = .customFont(.dmSans, weight: .regular, size: 14)
        resendOTPLabel.numberOfLines = 0
        resendOTPLabel.lineBreakMode = .byWordWrapping
        resendOTPLabel.textAlignment = .center
        
        mobileNumberLabel.textColor = .black4D4B5A
        mobileNumberLabel.font = .customFont(.dmSans, weight: .bold, size: 14)
        mobileNumberLabel.numberOfLines = 1
        mobileNumberLabel.lineBreakMode = .byWordWrapping
        mobileNumberLabel.textAlignment = .center
                
        titleLabel.text = "Enter your Mobile Number"
        otpTextField.title = "Enter OTP"
        
        resendOTPLabel.text = "Did not receive OTP? Resend in 00:00"
        
        verifyOTPButton.titleLabel?.font = .customFont(.poppins, weight: .medium, size: 16)
        verifyOTPButton.backgroundColor = .white
        verifyOTPButton.setTitle("Verify OTP", for: .normal)
        verifyOTPButton.setImage(.getImage(icon: .rightArrow)?.withTintColor(.black26262D), for: .normal)
        verifyOTPButton.tintColor = .black26262D
        verifyOTPButton.configuration?.imagePlacement = .trailing
        verifyOTPButton.set(cornerRadius: 0.2, borderWidth: 1, borderColor: .grayDFDFE3)
        verifyOTPButton.addShadow()
    }
    
    private func setupInitialStateForNoteLabel() {
        Task { @MainActor in
            let noteTitle = NSAttributedString(string: "NOTE: ",
                                          font: .customFont(.dmSans, weight: .bold, size: 14),
                                          color: .green40850A)
            let noteDescription = NSAttributedString(string: "Please enter the mobile number which you generally use for your banking purposes.",
                                                     font: .customFont(.dmSans, weight: .regular, size: 14),
                                                     color: .gray4D4B5A)
            self.noteLabel.attributedText = noteTitle.addAttributedString(noteDescription)
            self.noteLabel.textAlignment = .left
        }
    }
    
    private func setupOTPStateForNoteLabel() {
        Task { @MainActor in
            self.noteLabel.text = "We have sent a 4-digit OTP on your mobile number"
            self.noteLabel.font = .customFont(.dmSans, weight: .regular, size: 14)
            self.noteLabel.textColor = .black4D4B5A
            self.noteLabel.textAlignment = .center
            
            self.mobileNumberLabel.text = self.mobileTextField.text ?? "N/A"
        }
    }
    
    private func setOTPState(active: Bool) {
        Task { @MainActor in
            active ? self.setupOTPStateForNoteLabel() : self.setupInitialStateForNoteLabel()
            let isHidden = !active
            self.otpTextField.isHidden = isHidden
            self.resendOTPLabel.isHidden = isHidden
            self.mobileNumberLabel.isHidden = isHidden
            self.verifyOTPButton.isHidden = isHidden
        }
    }
    
    @IBAction func clickedVerifyOTPButton(_ sender: UIButton) {
        
    }
    
}

extension EnterMobileNumberViewController: GQMobileTextFieldDelegate {
    
    func textFieldDidClickSendOTP(_ textField: GQMobileTextField) {
        setOTPState(active: true)
    }
    
    func textFieldDidClickChange(_ textField: GQMobileTextField) {
        setOTPState(active: false)
    }
    
}

extension EnterMobileNumberViewController: GQTextFieldDelegate {
    
    func textField(_ textField: GQTextField, didChange text: String?) {
        if (text?.count ?? 0) == 4 {
            textField.resignErrorState()
        } else {
            textField.assignErrorState(message: "Incorrect OTP")
        }
    }
    
}
