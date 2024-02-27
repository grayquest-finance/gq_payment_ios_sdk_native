//
//  GQPaymentDelegate.swift
//  TestCases_Example
//
//  Created by valentine on 15/02/24.
//

import Foundation

public protocol GQPaymentDelegate {
    nonisolated func gqPayment(_ gqPayment: GQPayment, onSuccess data: [String: Any]?)
    nonisolated func gqPayment(_ gqPayment: GQPayment, onFailure data: [String: Any]?, error: Error)
    nonisolated func gqPayment(_ gqPayment: GQPayment, onCancel data: [String: Any]?)
}

