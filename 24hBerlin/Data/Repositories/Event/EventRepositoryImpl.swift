import Foundation

class EventRepositoryImpl: EventRepository {
    private let baseUrl = "https://www.twenty-four-hours.info/wp-json/eventon/"
    private let webService = WebService()

    // --- Entry Point ---
    func getProcessedEvents() async throws -> [Event] {
        let rawData = try await loadEvents()
        return await transformToDisplayList(eventsMap: rawData)
    }

    // --- Network Layer ---
    func loadEvents() async throws -> [String: Event] {
        let urlString = baseUrl + "events?post_status=publish"
        let result: ServerResponse = try await webService.downloadData(urlString: urlString)
        return result.events
    }

    // --- Logic Layer ---
    func transformToDisplayList(eventsMap: [String: Event]) async -> [Event] {
        let now = Date()

        // 1. Flatten/Expand repeatable events
        let allEvents = eventsMap.flatMap { (key, event) in
            expandRepeatableEvent(originalId: key, event: event)
        }

        // 2. Filter & Sort
        return allEvents
            .filter { isEventActive(event: $0, now: now) }
            .sorted {
                if $0.start == $1.start {
                    return $0.name < $1.name
                }
                return $0.start < $1.start
            }
    }

    // --- Worker: Expand Repeatable ---
    private func expandRepeatableEvent(originalId: String, event: Event) -> [Event] {
        guard let repeats = event.repeats, !repeats.isEmpty else {
            var singleEvent = event
            singleEvent.id = originalId
            return [singleEvent]
        }

        return repeats.enumerated().map { (index, repeatData) in
            let startTimeSeconds = repeatData.count > 0 ? repeatData[0] : nil
            let endTimeSeconds = repeatData.count > 1 ? repeatData[1] : nil

            let newStart = startTimeSeconds != nil
                ? Date(timeIntervalSince1970: TimeInterval(startTimeSeconds!))
                : event.start

            let newEnd = endTimeSeconds != nil
                ? Date(timeIntervalSince1970: TimeInterval(endTimeSeconds!))
                : nil

            var repeatedEvent = event
            repeatedEvent.id = "\(originalId)-\(index)"
            repeatedEvent.start = newStart
            repeatedEvent.end = newEnd
            repeatedEvent.repeats = nil
            return repeatedEvent
        }
    }

    // --- Worker: Is Active ---
    private func isEventActive(event: Event, now: Date) -> Bool {
        let expiryTime: Date
        if let end = event.end {
            expiryTime = end
        } else {
            let calendar = Calendar.current
            let nextDay = calendar.date(byAdding: .day, value: 1, to: event.start) ?? event.start
            expiryTime = calendar.startOfDay(for: nextDay)
        }
        
        return expiryTime >= now
    }
}
