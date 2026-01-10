//
//  EventRepositoryProtocol.swift
//  24hBerlin
//
//  Created by Emanuel Sutor on 19.12.24.
//

protocol EventRepository {
    func getProcessedEvents() async throws -> [Event]
    func loadEvents() async throws -> [String: Event]
    func transformToDisplayList(eventsMap: [String: Event]) async -> [Event]
}
