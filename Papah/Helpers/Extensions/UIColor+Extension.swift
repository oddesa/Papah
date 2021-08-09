//
//  UIColor+Extension.swift
//  Papah
//
//  Created by Papah Team.
//  swiftlint:disable all

import UIKit

// MARK: - Colors Asset

extension UIColor {

    static let backgroundGreen = UIColor.color(named: "background_green")
    static let backgroundPrimary = UIColor.color(named: "background_primary")
    static let backgroundPurple = UIColor.color(named: "background_purple")
    static let backgroundSecondary = UIColor.color(named: "background_secondary")
    static let bar = UIColor.color(named: "bar")
    static let buttonSmall = UIColor.color(named: "button_small")
    static let chevron = UIColor.color(named: "chevron")
    static let completion = UIColor.color(named: "completion")
    static let disabled = UIColor.color(named: "disabled")
    static let link = UIColor.color(named: "link")
    static let link10 = UIColor.color(named: "link_10")
    static let link60 = UIColor.color(named: "link_60")
    static let linkUnselected = UIColor.color(named: "link_unselected")
    static let separator = UIColor.color(named: "separator")
    static let textPrimary = UIColor.color(named: "text_primary")
    static let textSecondary = UIColor.color(named: "text_secondary")

    private static func color(named: String) -> UIColor {
        return UIColor(named: named)!
    }

}

