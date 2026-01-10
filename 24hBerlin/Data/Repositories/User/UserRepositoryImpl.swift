//
//  UserRepository.swift
//  24hBerlin
//
//  Created by Emanuel Sutor on 19.12.24.
//

import FirebaseFirestore
import Foundation

class UserRepositoryImpl: UserRepository {
    private let fb = FirebaseManager.shared
    private let userRef: CollectionReference
    
    init() {
        userRef = fb.database.collection("users")
    }
    
    func register(email: String, password: String) async throws {
        let result = try await fb.auth.createUser(withEmail: email, password: password)
        let user = AppUser()
        
        try userRef
            .document(result.user.uid)
            .setData(from: user)
    }
    
    func addUserListener(onChange: @escaping (AppUser) -> Void) -> ListenerRegistration? {
        guard let userId = fb.currentUserID else { return nil }
        
        return userRef
            .document(userId)
            .addSnapshotListener { querySnapshot, error in
                do {
                    guard let querySnapshot else { return }
                    let user = try querySnapshot.data(as: AppUser.self)
                    onChange(user)
                } catch {
                    print(error)
                }
            }
    }
    
    func updateUserInformation(favoriteID: String? = nil, settings: Settings? = nil) async throws {
        guard let userId = fb.currentUserID else { return }
        
        var values: [String: Any] = [:]
        if let favoriteID { values["favoriteIDs"] = FieldValue.arrayUnion([favoriteID]) }
        if let settings { values["settings"] = [
            "pushNotificationsEnabled" : settings.pushNotificationsEnabled,
            "language" : settings.language as Any
        ] }
        
        guard !values.isEmpty else { return }
        
        try await userRef
            .document(userId)
            .updateData(values)
    }
    
    func deleteUserDataAndAuth() async throws {
        guard let userId = fb.currentUserID else { return }
        
        try await userRef
            .document(userId)
            .delete()
        
        try await fb.auth.currentUser?.delete()
    }
    
    func removeFavoriteID(favoriteID: String) async throws {
        guard let userId = fb.currentUserID else { return }
        
        try await userRef
            .document(userId)
            .setData(["favoriteIDs": FieldValue.arrayRemove([favoriteID])], merge: true)
    }
    
    func sendBugReport(message: String, completion: @escaping (Error?) -> Void) {
        guard let currentUser = fb.auth.currentUser else {
            completion(NSError(domain: "BugReportError", code: 1, userInfo: [NSLocalizedDescriptionKey: "User not signed in"]))
            return
        }
        
        let bugReportData: [String: Any] = [
            "message": message,
            "user_uid": currentUser.uid,
            "user_email": currentUser.email ?? "N/A",
            "timestamp": FieldValue.serverTimestamp(),
            "app_version": Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "N/A",
            "device_info": UIDevice.current.modelName
        ]
        
        fb.database.collection("bug_reports")
            .addDocument(data: bugReportData) { error in
                if let error = error {
                    completion(error)
                } else {
                    completion(nil)
                    print("Bug report sent successfully!")
                }
            }
    }
}
