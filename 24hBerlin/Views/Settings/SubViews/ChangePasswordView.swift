//
//  ChangePasswordView.swift
//  24hBerlin
//
//  Created by Emanuel Sutor on 22.01.25.
//

import SwiftUI

struct ChangePasswordView: View {
    @ObservedObject var settingsVM: SettingsViewModel
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack(alignment: .leading, spacing: 0) {
                Text("change_your_password")
                    .font(.title3)
                    .bold()
                    .padding(.bottom, largePadding)
                
                PasswordField(
                    text: $settingsVM.newPassword,
                    title: "new_password",
                    hint: "please_enter_your_new_password"
                )
                .padding(.bottom, regularPadding)
                
                PasswordField(
                    text: $settingsVM.confirmNewPassword,
                    title: "confirm_new_password",
                    hint: "please_confirm_your_new_password"
                )
                
                if let passwordError = settingsVM.passwordError {
                    Text(LocalizedStringKey(passwordError))
                        .errorMessageStyle()
                        .padding(.top, errorPadding)
                }
                
                if let error = settingsVM.errorMessage {
                    Text(LocalizedStringKey(error))
                        .errorMessageStyle()
                        .padding(.top, errorPadding)
                }
                
                if let confirmation = settingsVM.confirmationMessage {
                    Text(LocalizedStringKey(confirmation))
                        .confirmationMessageStyle()
                        .padding(.top, errorPadding)                }
                
                Button(action: {
                    settingsVM.changePassword()
                }) {
                    Text("change_password")
                        .darkButtonStyle()
                }
                .padding(.top, extraLargePadding)
            }
            .navigationTitle("change_password")
            
            Spacer()
        }
        .onAppear(perform: { settingsVM.errorMessage = nil })
        .background(
            Image("background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        )
    }
}
