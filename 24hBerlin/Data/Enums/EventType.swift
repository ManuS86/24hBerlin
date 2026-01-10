//
//  EventTypeEnum.swift
//  24hBerlin
//
//  Created by Emanuel Sutor on 18.01.25.
//

import Foundation

enum EventType: String, CaseIterable, Identifiable {
    case concert = "Konzert"
    case artAndCulture = "Kunst & Kultur"
    case party = "Party"
    
    var id: String { rawValue }
}
