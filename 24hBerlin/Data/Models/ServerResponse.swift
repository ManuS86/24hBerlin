//
//  ServerResponse.swift
//  24hBerlin
//
//  Created by Emanuel Sutor on 03.01.25.
//

import Foundation

struct ServerResponse: Codable {
    var events: [String: Event]
}
