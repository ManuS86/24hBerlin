//
//  Language.swift
//  24hBerlin
//
//  Created by Emanuel Sutor on 19.01.25.
//

import Foundation

enum Language: String, CaseIterable, Identifiable {
    case english, german

    var id: String { rawValue }
}
