//
//  EventRepository.swift
//  24hBerlin
//
//  Created by Emanuel Sutor on 19.12.24.
//

class EventRepository: EventRepositoryProtocol {
    private let baseUrl = "https://www.twenty-four-hours.info/wp-json/eventon/"
    
    func getEvents() async throws -> [String: Event] {
        let result: ServerResponse = try await WebService().downloadData(urlString: baseUrl + "events?post_status=publish")
        return result.events
    }
}
