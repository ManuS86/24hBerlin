//
//  Webservice.swift
//  24hBerlin
//
//  Created by Emanuel Sutor on 19.12.24.
//

import Foundation

class WebService {
    func downloadData<T: Codable>(urlString: String) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw HTTPError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let result = try JSONDecoder().decode(T.self, from: data)
        
        return result
    }
}
