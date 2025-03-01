//
//  SettingsView.swift
//  24hBerlin
//
//  Created by Emanuel Sutor on 19.12.24.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var eventVM: EventViewModel
    @EnvironmentObject private var languageSettings: LanguageSettings
    @EnvironmentObject private var settingsVM: SettingsViewModel
    @State private var showAlertDel = false
    @State private var showAlertLog = false
    @State private var showBugReport: Bool = false
    
    private let logoSize: CGFloat = 40
    
    var body: some View {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Account Details")
                        .font(.body)
                        .fontWeight(.medium)
                    
                    VStack {
                        HStack {
                            Text("change_email")
                            
                            NavigationLink(destination: reAuthWrapper(settingsVM: settingsVM, from: 0)
                                .toolbarStyle(.hidden)) {
                                    Image(systemName: "chevron.right")
                                        .font(.footnote)
                                        .foregroundColor(.gray)
                                        .maxWidth(.trailing)
                                }
                        }
                        .padding(.bottom, smallPadding)
                        
                        Divider()
                        
                        HStack {
                            Text("change_password")
                            NavigationLink(destination: reAuthWrapper(settingsVM: settingsVM, from: 1)
                                .toolbarStyle(.hidden)) {
                                    Image(systemName: "chevron.right")
                                        .font(.footnote)
                                        .foregroundColor(.gray)
                                        .maxWidth(.trailing)
                                }
                        }
                        .padding(.top, smallPadding)
                    }
                    .maxWidth()
                    .padding(regularPadding)
                    .settingsFieldStyle()
                    .padding(.bottom, regularPadding)
                    
                    Text("app_settings")
                        .font(.body)
                        .fontWeight(.medium)
                    
                    HStack {
                        Text("language_settings")
                        
                        Spacer()
                        
                        Picker("Language", selection: $settingsVM.selectedLanguage) {
                            Text("system_default")
                                .tag(nil as Language?)
                            
                            ForEach(Language.allCases) { language in
                                Text(LocalizedStringKey(language.rawValue))
                                    .tag(language)
                            }
                        }
                        .tint(.black)
                        .onChange(of: settingsVM.selectedLanguage) {
                            switch settingsVM.selectedLanguage {
                            case .english: languageSettings.setLanguage("en")
                            case .german: languageSettings.setLanguage("de")
                            case .none: languageSettings.resetToSystemLanguage()
                            }
                            settingsVM.saveSettings()
                        }
                    }
                    .maxWidth()
                    .padding(.leading, regularPadding)
                    .padding(.trailing, mediumPadding)
                    .padding(.vertical, mediumPadding)
                    .settingsFieldStyle()
                    .padding(.bottom, mediumPadding)
                    
                    Toggle("push_notifications", isOn: $settingsVM.pushNotificationsEnabled)
                        .maxWidth()
                        .padding(.horizontal, regularPadding)
                        .padding(.vertical, mediumPadding)
                        .settingsFieldStyle()
                        .padding(.bottom, regularPadding)
                        .onChange(of: settingsVM.pushNotificationsEnabled) {
                            if settingsVM.pushNotificationsEnabled {
                                for event in eventVM.favorites {
                                    eventVM.addFavoritePushNotification(event: event, dayModifier: 2, hourModifier: 11)
                                    eventVM.addFavoritePushNotification(event: event, dayModifier: 0, hourModifier: 11)
                                    eventVM.addFavoritePushNotification(event: event, dayModifier: 0, hourModifier: 2)
                                }
                                settingsVM.saveSettings()
                            } else {
                                settingsVM.removeAllPendingNotifications()
                                settingsVM.saveSettings()
                            }
                        }
                    
                    Text("Community")
                        .font(.body)
                        .fontWeight(.medium)
                    
                    ShareLink(items: [URL(string: "https://itunes.apple.com/app/24h-berlin")!]) {
                        Text("share_24hberlin")
                            .fontWeight(.medium)
                            .maxWidth(.leading)
                            .padding(regularPadding)
                            .settingsFieldStyle()
                            .padding(.bottom, mediumPadding)
                    }
                    
                    Button {
                        showBugReport = true
                    } label: {
                        Text("report_a_bug")
                            .fontWeight(.medium)
                            .maxWidth(.leading)
                            .padding(regularPadding)
                            .settingsFieldStyle()
                            .padding(.bottom, extraLargePadding)
                    }
                    
                    Button {
                        showAlertLog = true
                    } label: {
                        Text("logout")
                            .font(.body)
                            .fontWeight(.medium)
                            .maxWidth()
                            .padding(regularPadding)
                            .settingsFieldStyle()
                    }
                    .alert("log_out?", isPresented: $showAlertLog) {
                        Button("confirm", role: .destructive) {
                            settingsVM.logout()
                        }
                    }
                    
                    VStack {
                        Image("logo")
                            .resizable()
                            .scaledToFill()
                            .frame(width: logoSize, height: logoSize)
                        
                        Text("Version 1.0")
                            .font(.caption2)
                            .foregroundStyle(.gray)
                    }
                    .maxWidth()
                    .padding(40)
                    
                    Button {
                        showAlertDel = true
                    } label: {
                        Text("delete_account")
                            .maxWidth()
                            .padding(regularPadding)
                            .settingsFieldStyle()
                    }
                    .alert("delete_account", isPresented: $showAlertDel) {
                        Button("Confirm", role: .destructive) {
                            settingsVM.deleteAccount()
                        }
                    } message: {
                        Text("are_you_sure_you_want_to_delete_your_account?")
                    }
                }
                .font(.callout)
                .foregroundStyle(.black)
                .padding(regularPadding)
                .background(
                    Image("background")
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                )
                .sheet(isPresented: $showBugReport) {
                    BugReportView(showBugReport: $showBugReport)
                        .environmentObject(settingsVM)
                        .presentationDragIndicator(.visible)
                        .presentationDetents([.medium, .large])
                }
            }
            .scrollIndicators(.hidden)
            .background(
                Image("background")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            )
    }
}

#Preview {
    SettingsView()
        .environmentObject(SettingsViewModel())
}
