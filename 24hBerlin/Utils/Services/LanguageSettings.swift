//
//  LanguageSettings.swift
//  24hBerlin
//
//  Created by Emanuel Sutor on 20.01.25.
//


import SwiftUI

class LanguageSettings: ObservableObject {
    @AppStorage("selectedLanguage") var selectedLanguage: String?
    @Published var locale: Locale = Locale.current
    
    init() {
        if let selectedLanguage {
            locale = Locale(identifier: selectedLanguage)
        }
    }

    let availableLanguages = ["en", "de"]

    func setLanguage(_ language: String?) {
        selectedLanguage = language
        guard let language else {
            locale = Locale.current
            return
        }
        locale = Locale(identifier: language)
    }
    
    func resetToSystemLanguage() {
        setLanguage(nil)
    }
}
