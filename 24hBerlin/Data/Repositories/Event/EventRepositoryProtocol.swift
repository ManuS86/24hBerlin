//
//  EventRepositoryProtocol.swift
//  24hBerlin
//
//  Created by Emanuel Sutor on 19.12.24.
//

protocol EventRepositoryProtocol {
    func getEvents() async throws -> [String: Event]
}
