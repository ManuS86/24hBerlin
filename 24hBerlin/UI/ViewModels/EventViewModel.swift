//
//  EventsViewModel.swift
//  24hBerlin
//
//  Created by Emanuel Sutor on 19.12.24.
//

import FirebaseFirestore
import Foundation

@MainActor
class EventViewModel: ObservableObject {
    @Published var currentUser: AppUser?
    @Published var events: [Event] = []
    
    var favorites: [Event] {
        currentUser != nil ? events.filter { event in
            currentUser!.favoriteIDs.contains(event.id)
        } : []
    }
    
    var uniqueLocations: [String] {
        let nonNilLocations = events.compactMap { $0.locationName }
        return Array(Set(nonNilLocations)).sorted()
    }
    
    var uniqueSounds: [String] {
        let allSounds = events.flatMap { event -> [String] in
            return event.sounds?.values.map { String($0) } ?? []
        }
        return Array(Set(allSounds)).sorted()
    }
    
    private let eventRepo = EventRepositoryImpl()
    private let fb = FirebaseManager.shared
    private var listener: ListenerRegistration?
    private let notificationService = NotificationService.shared
    private let userRepo = UserRepositoryImpl()
    
    init() {
        if listener == nil {
            listener = userRepo.addUserListener { [weak self] user in
                self?.currentUser = user
            }
        }
        loadEvents()
        notificationService.requestAuthorization()
    }
    
    deinit {
        listener?.remove()
        listener = nil
    }
    
    func addFavoriteID(favoriteID: String) {
        guard let event = events.first(where: { $0.id == favoriteID }) else { return }
        
        Task {
            do {
                try await userRepo.updateUserInformation(favoriteID: favoriteID)
                if currentUser?.settings.pushNotificationsEnabled == true {
                    notificationService.scheduleEventReminder(for: event, dayModifier: 3, hourModifier: 11)
                    notificationService.scheduleEventReminder(for: event, dayModifier: 0, hourModifier: 11)
                    notificationService.scheduleEventReminder(for: event, dayModifier: 0, hourModifier: 2)
                }
            } catch {
                print("Error updating favorites: \(error)")
            }
        }
    }
    
    func loadEvents() {
        Task {
            do {
                self.events = try await eventRepo.getProcessedEvents()
            } catch {
                print("Error loading events: \(error)")
            }
        }
    }
    
    func addFavoritePushNotification(event: Event, dayModifier: Int, hourModifier: Int) {
        notificationService.scheduleEventReminder(for: event, dayModifier: dayModifier, hourModifier: hourModifier)
    }
    
    func removeFavoriteID(favoriteID: String) {
        guard let event = events.first(where: { $0.id == favoriteID }) else { return }
        
        Task {
            do {
                try await userRepo.removeFavoriteID(favoriteID: favoriteID)
                notificationService.unscheduleEventReminder(for: event)
            } catch {
                print("Error updating favorites: \(error)")
            }
        }
    }
    
    func setupAbsenceReminder() {
        notificationService.updateLastAppOpenDate()
        notificationService.schedule14DayReminder()
    }
    
    private func filterAndSortEvents(_ allEvents: [Event]) -> [Event] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        
        return allEvents.filter { event in
            calendar.compare(event.end != nil ? event.end! : event.start, to: today, toGranularity: .day) != .orderedAscending
        }
        .sorted(by: { $0.start < $1.start })
    }
    
    private func setEventIds(_ dictionary: [String: Event]) -> [Event] {
        var updatedEvents: [Event] = []
        
        for (id, var event) in dictionary {
            event.id = id
            updatedEvents.append(event)
        }
        return updatedEvents
    }
}
