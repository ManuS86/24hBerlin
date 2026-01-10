//
//  UserRepositoryProtocol.swift
//  24hBerlin
//
//  Created by Emanuel Sutor on 19.12.24.
//

import FirebaseFirestore

protocol UserRepository {
    func register(email: String, password: String) async throws
    func addUserListener(onChange: @escaping (AppUser) -> Void) -> ListenerRegistration?
    func updateUserInformation(favoriteID: String?, settings: Settings?) async throws
    func deleteUserDataAndAuth() async throws
    func removeFavoriteID(favoriteID: String) async throws
    func sendBugReport(message: String, completion: @escaping (Error?) -> Void)
}
