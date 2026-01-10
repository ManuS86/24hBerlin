//
//  PasswordField.swift
//  24hBerlin
//
//  Created by Emanuel Sutor on 20.01.25.
//

import SwiftUI

struct PasswordField: View {
    @Binding var text: String
    @FocusState var isFocused: Bool
    @State private var showPassword: Bool = false
    
    var title: String
    var hint: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(LocalizedStringKey(title))
                .font(.headline)
                .foregroundStyle(.black)
                .padding(.bottom, mediumPadding)
            
            ZStack(alignment: .trailing) {
                if showPassword {
                    TextField(LocalizedStringKey(hint), text: $text)
                        .autocapitalization(.none)
                        .padding(.trailing, 40)
                        .padding(.leading, regularPadding)
                        .focused($isFocused)
                } else {
                    SecureField(LocalizedStringKey(hint), text: $text)
                        .autocapitalization(.none)
                        .padding(.vertical, 0.9)
                        .padding(.trailing, 40)
                        .padding(.leading, regularPadding)
                        .focused($isFocused)
                }
                
                Button(action: {
                    showPassword.toggle()
                }) {
                    Image(systemName: showPassword ? "eye.slash" : "eye")
                        .foregroundColor(.gray)
                }
                .padding(.horizontal, mediumPadding)
            }
            .padding(.vertical, regularPadding)
            .background(.white)
            .overlay(
                RoundedRectangle(cornerRadius: slightRounding)
                    .stroke(isFocused ? .gray : .gray.opacity(0.5), lineWidth: 1)
            )
        }
    }
}
