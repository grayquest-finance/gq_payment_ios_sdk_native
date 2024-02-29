//
//  GQPayment.swift
//  TestCases_Example
//
//  Created by valentine on 15/02/24.
//

import UIKit

public final class GQPayment {
    
//    Theme Color to be displayed by the client.
    public static var themeColor: UIColor = .red991F2C
    
//    Framework bundle where it will be installed in client app.
    internal static var bundle: Bundle {
        return Bundle(for: Self.self)
    }
    
//    Delegate which will receive payment callback.
    public var delegate: (any GQPaymentDelegate)?
    
//    Presentation Style for the Initial Viewcontroller.
    public var presentationStyle: UIModalPresentationStyle = .pageSheet
    
//    Transition Style for the initial Viewcontroller.
    public var transitionStyle: UIModalTransitionStyle = .coverVertical
    
//    Initialise the class with certain properties
    public init(delegate: some GQPaymentDelegate) {
//        Loading Dependencies
        Self.loadDependencies()
        
        self.delegate = delegate
    }
    
    private static func loadDependencies() {
        UIFont.loadFonts()
    }
    
//    public func open(on viewController: UIViewController) {
//        Task { @MainActor in
//            let paymentViewmodel = PaymentMethodsViewModel()
//            let paymentViewcontroller = PaymentMethodsViewController(viewModel: paymentViewmodel)
//            let navigationController = UINavigationController(rootViewController: paymentViewcontroller)
//            navigationController.isModalInPresentation = true
//            viewController.present(navigationController, animated: true)
//        }
//    }
    
    public func open(on viewController: UIViewController) {
        Task { @MainActor in
            let mobileNumberViewmodel = EnterMobileNumberViewModel()
            let mobileNumberViewcontroller = EnterMobileNumberViewController(viewModel: mobileNumberViewmodel)
            
//        MARK: For Using Inbuilt Navigation BAR
            let navigationController = UINavigationController(rootViewController: mobileNumberViewcontroller)
            navigationController.modalPresentationStyle = self.presentationStyle
            navigationController.modalTransitionStyle = self.transitionStyle
            
//        MARK: For Using Custom Navigation BAR
//            let navigationController = UINavigationController(navigationBarClass: GQNavigationBar.self, toolbarClass: nil)
//            navigationController.setViewControllers([mobileNumberViewcontroller], animated: true)
            
            navigationController.isModalInPresentation = true
            viewController.present(navigationController, animated: true)
        }
    }
    
    public func setTheme(color: UIColor) {
        Self.themeColor = color
    }
    
}
