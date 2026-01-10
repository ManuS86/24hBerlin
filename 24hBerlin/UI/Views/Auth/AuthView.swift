//
//  AuthView.swift
//  24hBerlin
//
//  Created by Emanuel Sutor on 19.12.24.
//

import SwiftUI

struct AuthView: View {
    @ObservedObject var authVM: AuthViewModel
    
    var body: some View {
        if authVM.showRegister {
            RegisterView(authVM: authVM)
        } else {
            LoginView(authVM: authVM)
        }
    }
}

#Preview {
    AuthView(authVM: AuthViewModel())
}
