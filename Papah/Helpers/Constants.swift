//
//  Constants.swift
//  Papah
//
//  Created by Jehnsen Hirena Kane on 25/07/21.
//

import Foundation
import UIKit

class Constants {
    // swiftlint:disable identifier_name
    static let APP_VERSION = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    // swiftlint:enable identifier_name
    static let dataModel = "Papah"
    
    static let claimPointDistance = 300.0 //meters
    static let claimPointHours = 24 //hours
    static let claimPoinCategory = 1 //category
    
    static let claimPointWBKL = 100 //point
    static let userLevelScope = 500 //Level up criteria

}
