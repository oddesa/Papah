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
    
    // MARK: - Buka Tutup Logic
    func extractNameOfTheDay() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "id_ID")
        dateFormatter.dateFormat = "EEEE"
        let dayInWeek = dateFormatter.string(from: date)
        return dayInWeek
    }
    
    func extractHours() -> Int {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "id_ID")
        dateFormatter.dateFormat = "HH"
        let hourInDay = dateFormatter.string(for: date)
        return Int(hourInDay!)!
    }
    
    func extractMinutes() -> Int {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "id_ID")
        dateFormatter.dateFormat = "mm"
        let minutesInHour = dateFormatter.string(for: date)
        return Int(minutesInHour!)!
    }
    
    func countOperationalDay(text: String) -> Int {
        var splited = text.components(separatedBy: ["-", " "])
        splited = splited.filter {$0 != ""}
        return splited.count
    }
    
    func extractOperationalTime(operationalHour: String) -> [Int] {
        var splited = operationalHour.components(separatedBy: ["-", " ", "."])
        var operationalHourArray: [Int] = []
        splited = splited.filter {$0 != ""}
        for angka in splited {
            let integiii = Int(angka)
            operationalHourArray.append(integiii!)
        }
        return operationalHourArray
    }
    
    func timeChecker(operationalHour: String) -> Bool {
        let hourNow = extractHours()
        let minuteNow = extractMinutes()
        let openTimeArr = extractOperationalTime(operationalHour: operationalHour)
        if openTimeArr[0] < hourNow || (openTimeArr[0] == hourNow && openTimeArr[1] <= minuteNow) {
            if openTimeArr[2] > hourNow || (openTimeArr[2] == hourNow && openTimeArr[3] >= minuteNow) {
                return true
            } else {return false}
        } else {return false}
    }
    
    
    func bukaTutupChecker(operationalDay: String, operationalHour: String) -> Bool {
        if countOperationalDay(text: operationalDay) == 1 {
            let dayName = extractNameOfTheDay()
            if operationalDay == dayName {
                return timeChecker(operationalHour: operationalHour)
            } else {return false}
        } else {
            //ini karena senin - minggu tok
            let daysOfTheWeek = ["Senin", "Selasa", "Rabu", "Kamis", "Jumat", "Sabtu", "Minggu"]
            let dayName = extractNameOfTheDay()
            if daysOfTheWeek.contains(dayName) {
                return timeChecker(operationalHour: operationalHour)
            } else {return false}
        }
    }
}
