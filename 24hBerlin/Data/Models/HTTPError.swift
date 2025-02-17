//
//  HTTPError.swift
//  Quotely
//
//  Created by Emanuel Sutor on 13.11.24.
//

import Foundation

enum HTTPError: Error {
    case invalidURL, fetchFailed
    
    var message: String {
        switch self {
        case .invalidURL: "Invalid URL"
        case .fetchFailed: "Fetch Failed"
        }
    }
}
