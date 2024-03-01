//
//  GQMobileTextFieldDelegate.swift
//  GQPaymentIOSSDKNative
//
//  Created by valentine on 01/03/24.
//

import UIKit

@MainActor protocol GQMobileTextFieldDelegate {
    func textFieldDidClickSendOTP(_ textField: GQMobileTextField)
    func textFieldDidClickChange(_ textField: GQMobileTextField)
}

extension GQMobileTextFieldDelegate {
    func textFieldDidClickSendOTP(_ textField: GQMobileTextField) { }
    func textFieldDidClickChange(_ textField: GQMobileTextField) { }
}
