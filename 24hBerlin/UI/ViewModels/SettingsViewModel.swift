//
//  SettingsViewModel.swift
//  24hBerlin
//
//  Created by Emanuel Sutor on 02.01.25.
//

import FirebaseAuth
import FirebaseFirestore
import SwiftUI

@MainActor
class SettingsViewModel: ObservableObject {
    @Published var bugReport: String = ""
    @Published var confirmationMessage: String?
    @Published var confirmNewPassword: String = ""
    @Published var currentUser: AppUser?
    @Published var email: String = ""
    @Published var errorMessage: String?
    @Published var isReauthenticated = false
    @Published var newPassword: String = ""
    @Published var password: String = ""
    @Published var passwordError: String?
    @Published var pushNotificationsEnabled = true
    @Published var selectedLanguage: Language?
    
    private let fb = FirebaseManager.shared
    private var listener: ListenerRegistration?
    private let notificationService = NotificationService.shared
    private let userRepo = UserRepository()
    
    init() {
        if listener == nil {
            listener = userRepo.addUserListener { [weak self] user in
                self?.currentUser = user
                self?.pushNotificationsEnabled = user.settings.pushNotificationsEnabled
                if let language = user.settings.language {
                    self?.selectedLanguage = Language(rawValue: language)
                }
            }
        }
    }
    
    deinit {
        listener?.remove()
        listener = nil
    }
    
    func changeEmail() {
        Task {
            do {
                try await fb.auth.currentUser?.sendEmailVerification(beforeUpdatingEmail: email)
                errorMessage = nil
                confirmationMessage = "email_changed_successfully."
            } catch {
                confirmationMessage = nil
                errorMessage = error.localizedDescription
                print(error)
            }
        }
    }
    
    func changePassword() {
        errorMessage = nil
        passwordError = nil
        
        passwordError = checkPassword(newPassword, confirmNewPassword)
        
        if errorMessage == nil && passwordError == nil {
            Task {
                do {
                    try await fb.auth.currentUser?.updatePassword(to: newPassword)
                    errorMessage = nil
                    passwordError = nil
                    confirmationMessage = "password_changed_successfully."
                } catch {
                    confirmationMessage = nil
                    errorMessage = error.localizedDescription
                    print(error)
                }
            }
        }
    }
    
    func logout() {
        try? fb.auth.signOut()
    }
    
    func reAuthenticate() {
        errorMessage = nil
        guard let user = fb.auth.currentUser else { return }
        
        let credential = EmailAuthProvider.credential(withEmail: user.email ?? "", password: password)
        
        user.reauthenticate(with: credential) { result, error in
            if let error {
                self.errorMessage = error.localizedDescription
            } else {
                self.isReauthenticated = true
            }
        }
    }
    
    func removeAllPendingNotifications() {
        notificationService.removeAllPendingNotifications()
    }
    
    func saveSettings() {
        let settings = Settings(pushNotificationsEnabled: pushNotificationsEnabled, language: selectedLanguage != nil ? selectedLanguage!.rawValue : nil)
        
        Task {
            do {
                try await userRepo.updateUserInformation(settings: settings)
            } catch {
                print(error)
            }
        }
    }
    
    func sendBugReport(completion: @escaping (Error?) -> Void) {
        userRepo.sendBugReport(message: bugReport, completion: completion)
    }
    
    func deleteAccount() {
        Task {
            do {
                try await userRepo.deleteUserDataAndAuth()
            } catch {
                print(error)
            }
        }
    }
}
