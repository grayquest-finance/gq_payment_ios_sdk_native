//
//  GQBaseViewController.swift
//  TestCases_Example
//
//  Created by valentine on 15/02/24.
//

import UIKit

class GQBaseViewController: UIViewController {
    
    private weak var scrollViewToAdjust: UIScrollView?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupResignResponderTapGesture()
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
    
    func setupBackAction() {
//        Disable default back button functionality.
        navigationItem.hidesBackButton = true
        
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
            self.navigationController?.popViewController(animated: true)
        }
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
