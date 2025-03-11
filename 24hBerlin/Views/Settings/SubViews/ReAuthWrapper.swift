//
//  reEnterPasswordView.swift
//  24hBerlin
//
//  Created by Emanuel Sutor on 22.01.25.
//

import SwiftUI

struct ReAuthWrapper: View {
    @ObservedObject var settingsVM: SettingsViewModel
    
    var from: Int
    
    var body: some View {
        VStack {
            if settingsVM.isReauthenticated {
                if from == 0 {
                    ChangeEmailView(settingsVM: settingsVM)
                } else {
                    ChangePasswordView(settingsVM: settingsVM)
                }
            } else {
                Spacer()
                
                VStack(alignment: .leading, spacing: 0) {
                    PasswordField(
                        text: $settingsVM.password,
                        title: "please_re-enter_your_password",
                        hint: "re-enter_your_password"
                    )
                    
                    if let error = settingsVM.errorMessage {
                        Text(LocalizedStringKey(error))
                            .foregroundStyle(.red)
                            .font(.footnote)
                            .padding(.top, errorPadding)
                            .maxWidth()
                    }
                    
                    Button(action: {
                        settingsVM.reAuthenticate()
                    }) {
                        Text("verify_password")
                            .darkButtonStyle()
                            .padding(.top, extraLargePadding)
                    }
                }
                .navigationTitle("re-enter_password")
                
                Spacer()
            }
        }
        .padding(.horizontal, regularPadding)
        .onAppear(perform: {
            settingsVM.errorMessage = nil
            settingsVM.password = ""
        })
        .background(
            Image("background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        )
    }
}
