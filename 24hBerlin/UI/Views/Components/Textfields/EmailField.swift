//
//  EmailField.swift
//  24hBerlin
//
//  Created by Emanuel Sutor on 20.01.25.
//

import SwiftUI

struct EmailField: View {
    @Binding var text: String
    @FocusState var isFocused: Bool
    
    var title: String
    var hint: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(LocalizedStringKey(title))
                .font(.headline)
                .foregroundStyle(.black)
                .padding(.bottom, mediumPadding)
            
            TextField(LocalizedStringKey(hint), text: $text)
                .padding(regularPadding)
                .background(.white)
                .clipShape(.rect(cornerRadius: slightRounding))
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .focused($isFocused)
                .overlay(
                    RoundedRectangle(cornerRadius: slightRounding)
                        .stroke(isFocused ? .gray : .gray.opacity(0.5), lineWidth: 1)
                )
        }
    }
}
