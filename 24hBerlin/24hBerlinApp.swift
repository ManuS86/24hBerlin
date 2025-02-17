//
//  _4hBerlinApp.swift
//  24hBerlin
//
//  Created by Emanuel Sutor on 19.12.24.
//

import Firebase
import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        FirebaseApp.configure()
        return true
    }
}

@main
struct _4hBerlinApp: App {
    @StateObject var languageSettings = LanguageSettings()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            AuthWrapper()
                .environment(\.locale, languageSettings.locale)
                .environmentObject(languageSettings)
                .preferredColorScheme(.light)
        }
    }
}
