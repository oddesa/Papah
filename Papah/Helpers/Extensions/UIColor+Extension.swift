//
//  UIColor+Extension.swift
//  Papah
//
//  Created by Papah Team.
//  swiftlint:disable all

import UIKit

// MARK: - Colors Asset

extension UIColor {

    static let white = UIColor.color(named: "white")

    private static func color(named: String) -> UIColor {
        return UIColor(named: named)!
    }

}

