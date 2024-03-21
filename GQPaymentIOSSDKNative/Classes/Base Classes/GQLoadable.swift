//
//  GQLoadable.swift
//  GQPaymentIOSSDKNative
//
//  Created by valentine on 21/03/24.
//

import UIKit

protocol GQLoadable: UIViewController {
    var loader: GQLoaderViewController? { get set }
    
    @MainActor func showLoader()
    @MainActor func hideLoader()
}

extension GQLoadable {
    
    @MainActor func showLoader() {
        let loader = GQLoaderViewController()
        self.addChild(loader)
        self.view.addSubview(loader.view)
        loader.view.frame = self.view.bounds
        loader.didMove(toParent: self)
        self.loader = loader
    }

    @MainActor func hideLoader() {
        guard let loader else { return }
        loader.didMove(toParent: nil)
        loader.view.removeFromSuperview()
        loader.removeFromParent()
        self.loader = nil
    }
    
}
