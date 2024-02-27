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
        inactiveOTPState()
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
        otpTextField.title = "Enter OTP"
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
            let noteTitle = NSAttributedString(string: "We have sent a 4-digit OTP on your mobile number ",
                                          font: .customFont(.dmSans, weight: .regular, size: 14),
                                          color: .black4D4B5A)
            let noteDescription = NSAttributedString(string: self.mobileTextField.text ?? "N/A",
                                                     font: .customFont(.dmSans, weight: .bold, size: 14),
                                                     color: .black4D4B5A)
            self.noteLabel.attributedText = noteTitle.addAttributedString(noteDescription)
            self.noteLabel.textAlignment = .center
        }
    }
    
    private func inactiveOTPState() {
        Task { @MainActor in
            self.setupInitialStateForNoteLabel()
            self.otpTextField.isHidden = true
        }
    }
    
    private func activeOTPState() {
        Task { @MainActor in
            self.setupOTPStateForNoteLabel()
            self.otpTextField.isHidden = false
        }
    }
}

extension EnterMobileNumberViewController: GQMobileTextFieldDelegate {
    
    func textFieldDidClickSendOTP(_ textField: GQMobileTextField) {
        self.activeOTPState()
    }
    
    func textFieldDidClickChange(_ textField: GQMobileTextField) {
        self.inactiveOTPState()
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
