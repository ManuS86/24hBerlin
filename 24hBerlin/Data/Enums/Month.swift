//
//  Month.swift
//  24hBerlin
//
//  Created by Emanuel Sutor on 18.01.25.
//

import Foundation

enum Month: Int, CaseIterable, Identifiable {
    case january = 1, february, march, april, may, june, july, august, september, october, november, december

    var id: Int { rawValue }

    var englishName: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        let date = Calendar.current.date(from: DateComponents(year: 2000, month: self.rawValue, day: 1))!
        return dateFormatter.string(from: date).lowercased()
    }
}
