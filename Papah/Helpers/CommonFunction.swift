//
//  CommonFunction.swift
//  Papah
//
//  Created by Jehnsen Hirena Kane on 25/07/21.
//

import Foundation
import UIKit
import AVFoundation

class CommonFunction {
    static let shared = CommonFunction()
    
    func playSystemSound(id: UInt32) {
        AudioServicesPlaySystemSound(id)
    }
    
}
