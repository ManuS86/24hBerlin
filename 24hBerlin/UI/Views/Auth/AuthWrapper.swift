//
//  AuthWrapper.swift
//  24hBerlin
//
//  Created by Emanuel Sutor on 19.12.24.
//

import SwiftUI

struct AuthWrapper: View {
    @StateObject private var authVM = AuthViewModel()
    
    var body: some View {
        if authVM.user != nil {
            AppNavigation()
        } else {
            AuthView(authVM: authVM)
        }
    }
}

#Preview {
    @Previewable @StateObject var languageSettings = LanguageSettings()
    
    AuthWrapper()
        .environment(\.locale, languageSettings.locale)
        .environmentObject(languageSettings)
}
