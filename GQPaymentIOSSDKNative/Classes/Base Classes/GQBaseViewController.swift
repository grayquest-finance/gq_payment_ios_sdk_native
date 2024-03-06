//
//  GQBaseViewController.swift
//  TestCases_Example
//
//  Created by valentine on 15/02/24.
//

import UIKit

public class GQBaseViewController: UIViewController {
    
    private weak var scrollViewToAdjust: UIScrollView?
    internal var isBackButtonEnabled: Bool = true
    
    private weak var loader: UIActivityIndicatorView?
    
    public func showLoader() {
        Task { @MainActor in
            if let loader = self.loader {
                loader.startAnimating()
                loader.isHidden = false
            } else {
                let activityIndicator = UIActivityIndicatorView()
                activityIndicator.hidesWhenStopped = true
                activityIndicator.color = .black
                activityIndicator.backgroundColor = .black.withAlphaComponent(0.3)
                self.view.addSubview(activityIndicator)

                //Adding Constraints
                activityIndicator.translatesAutoresizingMaskIntoConstraints = false
                activityIndicator.center = self.view.center
                activityIndicator.heightAnchor.constraint(equalToConstant: 40).isActive = true
                activityIndicator.widthAnchor.constraint(equalToConstant: 40).isActive = true
                activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
                activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true

                activityIndicator.startAnimating()
                self.view.addSubview(activityIndicator)
                self.loader = activityIndicator
            }
            
            // disable interaction
            self.view.isUserInteractionEnabled = false
        }
    }

    public func hideLoader() {
        Task { @MainActor in
            self.loader?.stopAnimating()
            
            // enable interaction
            self.view.isUserInteractionEnabled = true
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupResignResponderTapGesture()
        setupCommonUI()
    }
    
    func setupNavigationBar() {
        guard let navigationController = self.navigationController else { return }
        
        let navBarAppearrance = UINavigationBarAppearance()
        navBarAppearrance.backgroundColor = .white
        navigationController.navigationBar.standardAppearance = navBarAppearrance
        navigationController.navigationBar.scrollEdgeAppearance = navBarAppearrance
        
        setupBackAction()
        setupCloseAction()
    }
    
    func setupCommonUI() {
        overrideUserInterfaceStyle = .light
    }
    
    func setupBackAction() {
//        Disable default back button functionality.
        navigationItem.hidesBackButton = true
        
        guard isBackButtonEnabled else { return }
        
//        Adding new back button functionality.
        let backButton = UIBarButtonItem(image: .getImage(icon: .backIcon,
                                                           renderingMode: .alwaysOriginal),
                                          style: .done,
                                          target: self,
                                          action: #selector(backButtonAction)
        )
        backButton.tintColor = .clear
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    @objc func backButtonAction(_ selector: Selector) {
        Task { @MainActor in
//            self.navigationController?.popViewController(animated: true)
            configureBackAction()
        }
    }
    
    internal func configureBackAction() {
        
    }
    
    func setupCloseAction() {
        let closeButton = UIBarButtonItem(image: .getImage(icon: .closeIcon,
                                                           renderingMode: .alwaysOriginal),
                                          style: .done,
                                          target: self,
                                          action: #selector(closeButtonAction)
        )
        closeButton.tintColor = .clear
        self.navigationItem.rightBarButtonItem = closeButton
    }
    
    @objc func closeButtonAction(_ selector: Selector) {
        Task { @MainActor in
            self.dismiss(animated: true)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

//MARK: Adjust Scrollview when Keyboard appears and disappears.
extension GQBaseViewController {
    
    public func adjustScrollViewForKeyboard(scrollView: UIScrollView) {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForHideKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForShowKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        scrollView.bounces = false
        self.scrollViewToAdjust = scrollView
    }
    
    @objc func adjustForShowKeyboard(notification: Notification) {
        guard let scrollView = self.scrollViewToAdjust else { return }
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        Task { @MainActor in
            let keyboardScreenEndFrame = keyboardValue.cgRectValue
            let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)

            let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)

            scrollView.contentInset = contentInset
            scrollView.scrollIndicatorInsets = contentInset
        }
    }
    
    @objc func adjustForHideKeyboard(notification: Notification) {
        guard let scrollView = self.scrollViewToAdjust else { return }
        
        Task { @MainActor in
            scrollView.contentInset = .zero
            scrollView.scrollIndicatorInsets = .zero
        }
    }
}

extension GQBaseViewController {
    
    private func setupResignResponderTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapMainView))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func didTapMainView(_ gesture: UITapGestureRecognizer) {
        // Check if first responder is a textfield
        self.view.endEditing(true)
    }
}
