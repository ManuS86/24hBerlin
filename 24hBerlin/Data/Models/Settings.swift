//
//  AppSettings.swift
//  24hBerlin
//
//  Created by Emanuel Sutor on 24.01.25.
//

import Foundation

struct Settings: Codable {
    var pushNotificationsEnabled: Bool = true
    var language: String? = nil
}
