//
//  UIColor+Extension.swift
//  Papah
//
//  Created by Papah Team.
//  swiftlint:disable all

import UIKit

// MARK: - Colors Asset

extension UIColor {

    static let backgroundPrimary = UIColor.color(named: "background_primary")
    static let backgroundSecondary = UIColor.color(named: "background_secondary")
    static let bar = UIColor.color(named: "bar")
    static let buttonSmall = UIColor.color(named: "button_small")
    static let chevron = UIColor.color(named: "chevron")
    static let disabled = UIColor.color(named: "disabled")
    static let iconAmazonite = UIColor.color(named: "icon_amazonite")
    static let iconAmethyst = UIColor.color(named: "icon_amethyst")
    static let iconApatite = UIColor.color(named: "icon_apatite")
    static let iconIolite = UIColor.color(named: "icon_iolite")
    static let iconSapphire = UIColor.color(named: "icon_sapphire")
    static let purpleOne = UIColor.color(named: "purple_one")
    static let purpleTwo = UIColor.color(named: "purple_two")
    static let separator = UIColor.color(named: "separator")
    static let textPrimary = UIColor.color(named: "text_primary")
    static let textSecondary = UIColor.color(named: "text_secondary")

    private static func color(named: String) -> UIColor {
        return UIColor(named: named)!
    }

}

