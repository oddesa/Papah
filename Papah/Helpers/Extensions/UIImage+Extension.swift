//
//
//  UIImage+Extension.swift
//  Papah
//
//  Created by Papah Team.
//  swiftlint:disable all

import UIKit

// MARK: - Images Asset

extension UIImage {

    static let whatsAppImage20210719At085013 = UIImage.image(named: "WhatsApp Image 2021-07-19 at 08.50.13")
    static let wbklBSURanggaMekar = UIImage.image(named: "wbkl_BSURanggaMekar")
    static let wbklBankSampahUnitCendana = UIImage.image(named: "wbkl_BankSampahUnitCendana")
    static let wbklBankSampahWarungJambuBersih = UIImage.image(named: "wbkl_BankSampahWarungJambuBersih")
    static let wbklLapakRongsokRDK = UIImage.image(named: "wbkl_LapakRongsokRDK")
    static let wbklCvCahayaBerkah = UIImage.image(named: "wbkl_cvCahayaBerkah")

    private static func image(named: String) -> UIImage {
        return UIImage(named: named)!
    }
}
