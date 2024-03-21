//
//  GQLoaderViewController.swift
//  GQPaymentIOSSDKNative
//
//  Created by valentine on 20/03/24.
//

import UIKit

final class GQLoaderViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    init() {
        super.init(nibName: "GQLoaderViewController", bundle: GQPaymentSDK.bundle)
        self.modalPresentationStyle = .overCurrentContext
        self.modalTransitionStyle = .crossDissolve
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        start()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        stop()
    }
    
    private func setupUI() {
        self.view.backgroundColor = .black.withAlphaComponent(0.8)
        
        self.activityIndicator.style = .large
        self.activityIndicator.color = .white
        self.activityIndicator.backgroundColor = .clear
        self.activityIndicator.hidesWhenStopped = true
    }
    
    @MainActor func start() {
        self.activityIndicator.startAnimating()
    }
    
    @MainActor func stop() {
        self.activityIndicator.stopAnimating()
    }

}
