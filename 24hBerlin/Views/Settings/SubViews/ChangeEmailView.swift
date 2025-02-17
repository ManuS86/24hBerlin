//
//  ChangeEmail.swift
//  24hBerlin
//
//  Created by Emanuel Sutor on 22.01.25.
//

import SwiftUI

struct ChangeEmailView: View {
    @ObservedObject var settingsVM: SettingsViewModel
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack(alignment: .leading, spacing: 0) {
                Text("change_your_email")
                    .font(.title3)
                    .bold()
                    .padding(.bottom, largePadding)
                
                EmailField(
                    text: $settingsVM.email,
                    title: "new_email",
                    hint: "please_enter_your_new_email"
                )
                
                if let error = settingsVM.errorMessage {
                    Text(LocalizedStringKey(error))
                        .errorMessageStyle()
                        .padding(.top, errorPadding)
                }
                
                if let confirmation = settingsVM.confirmationMessage {
                    Text(LocalizedStringKey(confirmation))
                        .confirmationMessageStyle()
                        .padding(.top, errorPadding)
                }
                
                Button(action: {
                    settingsVM.changeEmail()
                }) {
                    Text("change_email")
                        .darkButtonStyle()
                        .padding(.top, extraLargePadding)
                }
            }
            .navigationTitle("change_email")
            
            Spacer()
        }
        .onAppear { settingsVM.errorMessage = nil }
        .background(
            Image("background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        )
    }
}
