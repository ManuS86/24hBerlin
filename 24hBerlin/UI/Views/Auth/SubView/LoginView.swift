//
//  LoginView.swift
//  24hBerlin
//
//  Created by Emanuel Sutor on 23.12.24.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var authVM: AuthViewModel
    
    var body: some View {
        NavigationStack {
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
                        hint: "enter_your_email"
                    )
                    .padding(.bottom, regularPadding)
                    
                    PasswordField(
                        text: $authVM.password,
                        title: "password",
                        hint: "enter_your_password"
                    )
                    
                    if let error = authVM.errorMessage {
                        Text(LocalizedStringKey(error))
                            .errorMessageStyle()
                            .padding(.top, errorPadding)
                    }
                    
                    Button(action: {
                        authVM.login()
                    }) {
                        Text("login")
                            .darkButtonStyle()
                            .padding(.top, extraLargePadding)
                    }
                    
                    NavigationLink(destination: ForgotPasswordView(authVM: authVM)) {
                        Text("forgot_password?")
                            .bold()
                            .foregroundStyle(.black)
                    }
                    .buttonStyle(.borderless)
                    .maxWidth()
                    .padding(.top, extraLargePadding)
                }
                
                VStack {
                    Text("don’t_have_an_account?")
                        .foregroundStyle(.black.opacity(0.6))
                        .padding(.bottom, mediumPadding)
                    
                    Button(action: {
                        authVM.errorMessage = nil
                        authVM.showRegister.toggle()
                    }) {
                        Text("create_account")
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
        .tint(.black)
    }
}

#Preview {
    LoginView(authVM: AuthViewModel())
}
