//
//  ForgotPasswordView.swift
//  24hBerlin
//
//  Created by Emanuel Sutor on 20.01.25.
//

import SwiftUI

struct ForgotPasswordView: View {
    @ObservedObject var authVM: AuthViewModel
    
    private let logoSize: CGFloat = 120
    
    var body: some View {
        VStack(spacing: extraLargePadding) {
            Text("Twenty Four Hours Kulturprogramm")
                .appTitleStyle()
            
            Image("logo")
                .resizable()
                .scaledToFill()
                .frame(width: logoSize, height: logoSize)
            
            VStack(alignment: .leading, spacing: 0) {
                Text("reset_your_password")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(.black)
                    .maxWidth(.leading)
                    .padding(.bottom, regularPadding)
                
                EmailField(
                    text: $authVM.email,
                    title: "email",
                    hint: "please_enter_your_email"
                )
                
                if let error = authVM.errorMessage {
                    Text(LocalizedStringKey(error))
                        .errorMessageStyle()
                        .padding(.top, errorPadding)
                }
                
                if let confirmation = authVM.confirmationMessage {
                    Text(LocalizedStringKey(confirmation))
                        .confirmationMessageStyle()
                        .padding(.top, errorPadding)
                }
                
                Button(action: {
                    authVM.resetPassword()
                }) {
                    Text("reset_password")
                        .darkButtonStyle()
                }
                .padding(.top, extraLargePadding)
            }
            
            Spacer()
        }
        .padding(.horizontal, regularPadding)
        .onAppear(perform: {
            authVM.errorMessage = nil
            authVM.password = ""
            authVM.email = ""
        })
        .background(
            Image("background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        )
    }
}
