//
//  String+Extension.swift
//  Papah
//
//  Created by Jehnsen Hirena Kane on 25/07/21.
//

import Foundation
import UIKit

extension String {
    func withBoldText(text: String, font: UIFont? = nil) -> NSMutableAttributedString {
        let _font = font ?? UIFont.systemFont(ofSize: 14, weight: .light)
        let fullString = NSMutableAttributedString(string: self, attributes: [NSAttributedString.Key.font: _font])
        let boldFontAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: _font.pointSize)]
        let range = (self as NSString).range(of: text)
        fullString.addAttributes(boldFontAttribute, range: range)
        return fullString
    }}
