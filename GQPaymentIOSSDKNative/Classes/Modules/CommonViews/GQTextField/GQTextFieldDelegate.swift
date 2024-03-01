//
//  GQTextFieldDelegate.swift
//  GQPaymentIOSSDKNative
//
//  Created by valentine on 27/02/24.
//

import UIKit

@MainActor protocol GQTextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: GQTextField)
    func textFieldDidEndEditing(_ textField: GQTextField)
    func textField(_ textField: GQTextField, didChange text: String?)
}

extension GQTextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: GQTextField) { }
    func textFieldDidEndEditing(_ textField: GQTextField) { }
    func textField(_ textField: GQTextField, didChange text: String?) { }
}
