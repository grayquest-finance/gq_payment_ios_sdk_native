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
    
    @IBOutlet weak var noteOTPStackView: UIStackView!
    @IBOutlet weak var resentOTPStackView: UIStackView!
        
    @IBOutlet weak var mobileTextField: GQMobileTextField!
    @IBOutlet weak var otpTextField: GQTextField!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var mobileNumberLabel: UILabel!
    @IBOutlet weak var resendOTPLabel: UILabel!
    @IBOutlet weak var timerLabel: GQTimerLabel!
    
    @IBOutlet weak var verifyOTPButton: GQButton!
    
//  MARK: Variables
    private var viewModel: (any EnterMobileNumberViewModelType)?
    weak var gqPaymentSDK: GQPaymentSDK?
    
    init(viewModel: some EnterMobileNumberViewModelType) {
        super.init(nibName: "EnterMobileNumberViewController", bundle: GQPaymentSDK.bundle)
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
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: flag, completion: { [weak self] in
            self?.gqPaymentSDK?.dismiss(animated: true)
        })
    }
    
    public func configureUI() {
        //Needs to be called after API call.
        Task {
            await gileView.configure(with: viewModel?.gile)
        }
    }
    
    override func configureBackAction() {
        Task { @MainActor in
            let alert = UIAlertController(title: "Do you want to go back?", message: "Your changes will not be saved and discarded", preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "Okay", style: .default) { action in
                super.configureBackAction()
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            alert.addAction(okayAction)
            alert.addAction(cancelAction)
            self.present(alert, animated: true)
        }
    }

    private func setupUI() {
        setupLabels()
        setupTimerLabel()
        setupButtons()
        
        mobileTextField.delegate = self
        otpTextField.delegate = self
        otpTextField.isTitleEnabled = false
        otpTextField.onlyDigits = true

        setOTPState(active: false)
    }
    
    private func setupButtons() {
        verifyOTPButton.setTitle(with: .customFont(.poppins, weight: .medium, size: 16))
        verifyOTPButton.disabledStateBackgroundColor = .white
        verifyOTPButton.enabledStateBackgroundColor = .yellowFFCA00
        verifyOTPButton.setTitle(GQStaticText.verifyOTP.capitalized, for: .normal)
        verifyOTPButton.setTint(color: .black26262D)
        verifyOTPButton.setImage(.getImage(icon: .rightArrow), placement: .trailing)
        verifyOTPButton.setDisabled()
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
        resendOTPLabel.numberOfLines = 1
        resendOTPLabel.lineBreakMode = .byWordWrapping
        resendOTPLabel.textAlignment = .right
        
        mobileNumberLabel.textColor = .black4D4B5A
        mobileNumberLabel.font = .customFont(.dmSans, weight: .bold, size: 14)
        mobileNumberLabel.numberOfLines = 1
        mobileNumberLabel.lineBreakMode = .byWordWrapping
        mobileNumberLabel.textAlignment = .center
                
        titleLabel.text = GQStaticText.enterYourMobileNumber
        otpTextField.title = GQStaticText.enterOTP
        
        resendOTPLabel.text = GQStaticText.resendOTP
    }
    
    private func setupTimerLabel() {
        timerLabel.textColor = .black26262D
        timerLabel.font = .customFont(.dmSans, weight: .bold, size: 12)
        timerLabel.numberOfLines = 1
        timerLabel.lineBreakMode = .byWordWrapping
        timerLabel.textAlignment = .center
        timerLabel.backgroundColor = .purpleDCD6FF
        timerLabel.set(cornerRadius: 0.1)
        timerLabel.initialTime = 180 //seconds
        timerLabel.delegate = self
    }
    
    private func setupInitialStateForNoteLabel() {
        Task { @MainActor in
            let noteTitle = NSAttributedString(string: GQStaticText.note,
                                          font: .customFont(.dmSans, weight: .bold, size: 14),
                                          color: .green40850A)
            let noteDescription = NSAttributedString(string: GQStaticText.mobileNumberNote,
                                                     font: .customFont(.dmSans, weight: .regular, size: 14),
                                                     color: .gray4D4B5A)
            self.noteLabel.attributedText = noteTitle.addAttributedString(noteDescription)
            self.noteLabel.textAlignment = .left
        }
    }
    
    private func setupOTPStateForNoteLabel() {
        Task { @MainActor in
            self.noteLabel.text = GQStaticText.sentOTPMesssage
            self.noteLabel.font = .customFont(.dmSans, weight: .regular, size: 14)
            self.noteLabel.textColor = .black4D4B5A
            self.noteLabel.textAlignment = .center
            
            self.mobileNumberLabel.text = self.mobileTextField.text ?? GQStaticText.notknown
        }
    }
    
    private func setOTPState(active: Bool) {
        Task { @MainActor in

            if active {
                self.setupOTPStateForNoteLabel()
                self.timerLabel.startTimer()
                self.otpTextField.clear()
            } else {
                self.setupInitialStateForNoteLabel()
                self.timerLabel.resetTimer()
            }
            
            self.noteOTPStackView.alignment = active ? .center : .fill
            self.verifyOTPButton.setDisabled()
            
            let isHidden = !active
            self.otpTextField.isHidden = isHidden
            self.resentOTPStackView.isHidden = isHidden
            self.mobileNumberLabel.isHidden = isHidden
            self.verifyOTPButton.isHidden = isHidden
        }
    }
    
    @IBAction func clickedVerifyOTPButton(_ sender: UIButton) {
        GQLogger.shared.log(otpTextField.text ?? "No OTP")
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
        // Condition needs to be changed and OTP validity needs to be taken from API.
        if (text?.count ?? 0) == 4 {
            textField.resignErrorState()
            verifyOTPButton.setEnabled()
        } else {
            textField.assignErrorState(message: GQStaticText.incorrectOTP)
            verifyOTPButton.setDisabled()
        }
    }
    
}

extension EnterMobileNumberViewController: GQTimerLabelDelegate {
    
    func timerCountdownCompleted(_ timer: GQTimerLabel) {
        GQLogger.shared.log("Time's Up!!!")
    }
    
}
