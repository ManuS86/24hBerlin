//
//  AuthViewModel.swift
//  24hBerlin
//
//  Created by Emanuel Sutor on 19.12.24.
//

import Firebase
import FirebaseAuth
import Foundation

@MainActor
class AuthViewModel: ObservableObject {
    @Published var confirmationMessage: String?
    @Published var confirmPassword: String = ""
    @Published var email: String = ""
    @Published var errorMessage: String?
    @Published var password: String = ""
    @Published var passwordError: String?
    @Published var showRegister: Bool = false
    @Published var user: User?
    
    private let fb = FirebaseManager.shared
    private let userRepo = UserRepository()
    private var listener: NSObjectProtocol?
    
    init() {
        listener = fb.auth.addStateDidChangeListener { _, user in
            self.user = user
        }
    }
    
    deinit {
        listener = nil
    }
    
    func register() {
        errorMessage = nil
        passwordError = nil
        
        passwordError = checkPassword(password, confirmPassword)
        
        if errorMessage == nil && passwordError == nil {
            Task {
                do {
                    try await userRepo.register(email: email, password: password)
                    try await fb.auth.currentUser?.sendEmailVerification()
                } catch {
                    errorMessage = error.localizedDescription
                    print(error)
                }
            }
        }
    }
    
    func login() {
        errorMessage = nil
        
        Task {
            do {
                try await fb.auth.signIn(withEmail: email, password: password)
            } catch {
                errorMessage = "invalid_email_or_password."
                print(error)
            }
        }
    }
    
    func resetPassword() {
        Task {
            do {
                try await fb.auth.sendPasswordReset(withEmail: email)
                errorMessage = nil
                confirmationMessage = "email_sent."
            } catch {
                confirmationMessage = nil
                errorMessage = error.localizedDescription
                print(error)
            }
        }
    }
}
