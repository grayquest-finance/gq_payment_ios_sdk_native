//
//  GQPayment.swift
//  TestCases_Example
//
//  Created by valentine on 15/02/24.
//

import UIKit

public final class GQPayment {
    
    public static var themeColor: UIColor = .red991F2C
    
    internal static var bundle: Bundle {
        return Bundle(for: Self.self)
    }
    
    public init(delegate: some GQPaymentDelegate) {
        Self.loadDependencies()
        
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
//            navigationController.modalPresentationStyle = .overCurrentContext
//            navigationController.modalTransitionStyle = .crossDissolve
            
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
