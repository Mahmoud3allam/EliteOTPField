//
//  EliteOTPField + UITextFieldDelegete.swift
//  EliteOTPField
//
//  Created by Alchemist on 21/07/2022.
//

import Foundation

extension EliteOTPField :UITextFieldDelegate {
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let charactersCount = textField.text?.count else {return false}
        return charactersCount < digitsLabels.count || string == ""
    }
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        editingStatus?(.Begain)
    }
    public func textFieldDidEndEditing(_ textField: UITextField) {
        editingStatus?(.Ended)
    }
}

enum OTPEditingStatus {
    case Begain
    case Ended
}
