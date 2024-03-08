//
//  GQLogger.swift
//  GQPaymentIOSSDKNative
//
//  Created by valentine on 01/03/24.
//

import Foundation
import OSLog

class GQLogger {
    
    static let shared = GQLogger()
    
    private var logger = Logger(subsystem: GQPaymentSDK.bundle.bundleIdentifier ?? .empty, category: "GQLog")
    
    internal func log(_ text: String) {
        guard GQPaymentSDK.debugMode else { return }
        logger.log("\(text)")
    }
    
    internal func alert(_ text: String) {
        guard GQPaymentSDK.debugMode else { return }
        logger.warning("\(text)")
    }
    
    internal func info(_ text: String) {
        guard GQPaymentSDK.debugMode else { return }
        logger.info("\(text)")
    }
    
    internal func error(_ text: String) {
        guard GQPaymentSDK.debugMode else { return }
        logger.critical("\(text)")
    }
    
}
