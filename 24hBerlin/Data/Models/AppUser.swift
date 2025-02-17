//
//  AppUser.swift
//  24hBerlin
//
//  Created by Emanuel Sutor on 19.12.24.
//

import FirebaseFirestore

struct AppUser: Codable, Identifiable {
    @DocumentID var id: String?
    var favoriteIDs: [String] = []
    var registerDate: Date = Date()
    var settings: Settings = Settings()
}
