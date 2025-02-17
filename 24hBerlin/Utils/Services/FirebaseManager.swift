//
//  FirebaseManager.swift
//  24hBerlin
//
//  Created by Emanuel Sutor on 19.12.24.
//

import FirebaseAuth
import FirebaseFirestore

class FirebaseManager {
    static let shared = FirebaseManager()
    private init() {}
    
    let auth = Auth.auth()
    let database = Firestore.firestore()
    
    var currentUserID: String? {
        auth.currentUser?.uid
    }
}
