//
//  AppNavigation.swift
//  24hBerlin
//
//  Created by Emanuel Sutor on 19.12.24.
//

import SwiftUI

struct AppNavigation: View {
    @StateObject private var eventsVM = EventViewModel()
    @StateObject private var mapVM = MapViewModel()
    @StateObject private var settingsVM = SettingsViewModel()
    
    init() {
        let appearance = UITabBarAppearance()
        UITabBar.appearance().unselectedItemTintColor = .white
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
        UISearchBar.appearance().overrideUserInterfaceStyle = .dark
        
    }
    
    var body: some View {
        TabView {
            NavigationStack {
                EventListView()
                    .environmentObject(eventsVM)
                    .environmentObject(mapVM)
                    .environmentObject(settingsVM)
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Text("events")
                                .navigationTitleStyle()
                        }
                    }
                    .toolbarStyle()
                    .tint(.none)
            }
            .tabItem {
                Label("events", systemImage: "calendar.and.person")
            }
            
            NavigationStack {
                ClubMapView()
                    .environmentObject(eventsVM)
                    .environmentObject(mapVM)
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Text("club_map")
                                .navigationTitleStyle()
                        }
                    }
                    .toolbarStyle()
                    .tint(.none)
            }
            .tabItem {
                Label("club_map", systemImage: "map.fill")
            }
            
            NavigationStack {
                FavoritesListView()
                    .environmentObject(eventsVM)
                    .environmentObject(mapVM)
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Text("my_events")
                                .navigationTitleStyle()
                        }
                    }
                    .toolbarStyle()
                    .tint(.none)
            }
            .tabItem {
                Label("my_events", systemImage: "star")
            }
            
            NavigationStack {
                SettingsView()
                    .environmentObject(eventsVM)
                    .environmentObject(settingsVM)
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Text("settings")
                                .navigationTitleStyle()
                        }
                    }
                    .toolbarStyle()
                    .tint(.none)
            }
            .tabItem {
                Label("settings", systemImage: "gear")
            }
        }
        .tint(.white)
    }
}

#Preview {
    @Previewable @StateObject var languageSettings = LanguageSettings()
    
    AppNavigation()
        .environment(\.locale, languageSettings.locale)
        .environmentObject(languageSettings)
}
