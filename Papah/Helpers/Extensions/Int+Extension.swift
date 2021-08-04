//
//  Int+Extension.swift
//  Papah
//
//  Created by Dhiky Aldwiansyah on 03/08/21.
//

import Foundation

extension Int {
    func currencyFormatter() -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale.init(identifier: "id_ID")
        formatter.numberStyle = .currency
        if let formattedTipAmount = formatter.string(from: self as NSNumber) {
            return "\(formattedTipAmount)"
        }
        return ""
    }

}

extension Float {
    func currencyFormatter() -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale.init(identifier: "id_ID")
        formatter.numberStyle = .currency
        if let formattedTipAmount = formatter.string(from: self as NSNumber) {
            return "\(formattedTipAmount)"
        }
        return ""
    }

}
