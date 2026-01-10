//
//  RegisterView.swift
//  24hBerlin
//
//  Created by Emanuel Sutor on 23.12.24.
//

import SwiftUI

struct RegisterView: View {
    @ObservedObject var authVM: AuthViewModel
    @State private var showPassword = false
    @State private var showConfirmPassword = false
    
    private let logoSize: CGFloat = 120
    
    var body: some View {
            VStack(spacing: largePadding) {
                Text("Twenty Four Hours Kulturprogramm")
                    .appTitleStyle()
                
                Image("logo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: logoSize, height: logoSize)
                
                VStack(alignment: .leading, spacing: 0) {
                    EmailField(
                        text: $authVM.email,
                        title: "email",
                        hint: "enter_an_email"
                    )
                    .padding(.bottom, regularPadding)
                    
                    PasswordField(
                        text: $authVM.password,
                        title: "password",
                        hint: "create_a_password"
                    )
                    .padding(.bottom, regularPadding)
                    
                    PasswordField(
                        text: $authVM.confirmPassword,
                        title: "confirm_password",
                        hint: "confirm_your_password"
                    )
                    
                    if let passwordError = authVM.passwordError {
                        Text(LocalizedStringKey(passwordError))
                            .errorMessageStyle()
                            .padding(.top, errorPadding)
                    }
                    
                    if let error = authVM.errorMessage {
                        Text(LocalizedStringKey(error))
                            .errorMessageStyle()
                            .padding(.top, errorPadding)
                    }
                    
                    Button(action: {
                        authVM.register()
                    }) {
                        Text("create_account")
                            .darkButtonStyle()
                    }
                    .padding(.top, extraLargePadding)
                }
                
                VStack {
                    Text("already_have_an_account?")
                        .foregroundStyle(.black.opacity(0.6))
                        .padding(.bottom, mediumPadding)
                    
                    Button(action: {
                        authVM.errorMessage = nil
                        authVM.showRegister.toggle()
                    }) {
                        Text("login")
                            .bold()
                            .foregroundStyle(.black)
                    }
                    .buttonStyle(.borderless)
                }
                .maxHeight(.bottom)
                .padding(.bottom, largePadding)
        }
        .padding(.horizontal, regularPadding)
        .onAppear(perform: {
            authVM.errorMessage = nil
            authVM.passwordError = nil
            authVM.email = ""
            authVM.password = ""
            authVM.confirmPassword = ""
        })
        .background(
            Image("background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        )
    }
}

#Preview {
    RegisterView(authVM: AuthViewModel())
}
