//
//  NotificationService.swift
//  24hBerlin
//
//  Created by Emanuel Sutor on 18.01.25.
//

import UserNotifications

class NotificationService {
    static let shared = NotificationService()
    let notificationKey = "LastAppOpenDate"
    private init() {}
    
    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert, .badge, .sound]
        ) { success, error in }
    }
    
    func schedule14DayReminder() {
        let center = UNUserNotificationCenter.current()

        center.getPendingNotificationRequests { requests in
            let existingNotification = requests.first { $0.identifier.hasPrefix("14DayReminder") }

            if let existingNotification = existingNotification,
               let trigger = existingNotification.trigger as? UNCalendarNotificationTrigger {
                if let existingTriggerDate = trigger.dateComponents.date,
                   let triggerDate = Calendar.current.date(byAdding: .day, value: 14, to: Date()),
                   Calendar.current.isDate(existingTriggerDate, inSameDayAs: triggerDate) {
                    return
                } else {
                    center.removePendingNotificationRequests(withIdentifiers: [existingNotification.identifier])
                }
            }

            let content = UNMutableNotificationContent()
            content.title = "we_miss_you!"
            content.body = "come_back_and_check_out_the_latest_events."
            content.sound = .default

            guard let triggerDate = Calendar.current.date(byAdding: .day, value: 14, to: Date()) else {
                print("Could not calculate trigger date")
                return
            }

            let triggerComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: triggerDate)
            let trigger = UNCalendarNotificationTrigger(dateMatching: triggerComponents, repeats: false)

            let request = UNNotificationRequest(identifier: "14DayReminder-\(UUID().uuidString)", content: content, trigger: trigger)

            center.add(request) { error in
                if let error = error {
                    print("Error scheduling notification: \(error)")
                } else {
                    UserDefaults.standard.set(Date(), forKey: self.notificationKey)
                    print("14-day reminder scheduled for \(triggerDate)")
                }
            }
        }
    }

    
    func scheduleEventReminder(for event: Event, dayModifier: Int, hourModifier: Int) {
        let content = UNMutableNotificationContent()
        content.title = "event_reminder"
        content.body =
        if dayModifier == 2 {
            "don't_forget:_\(event.name)_is_happening_in_2_days!"
        } else if hourModifier == 2 {
            "don't_forget:_\(event.name)_is_happening_in_3_hours!"
        } else {
            "don't_forget:_\(event.name)_is_happening_today!"
        }
        content.sound = .default

        guard let triggerDate = Calendar.current.date(byAdding: .day, value: -dayModifier, to: event.start) else {
            print("Could not calculate trigger date")
            return
        }

        var triggerComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: triggerDate)

            if hourModifier > 0 {
                guard let finalTriggerDate = Calendar.current.date(byAdding: .hour, value: -hourModifier, to: triggerDate) else {
                    print("Could not calculate final trigger date with hour modifier")
                    return
                }
                triggerComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: finalTriggerDate)
            } else {
                let eventComponents = Calendar.current.dateComponents([.hour, .minute], from: event.start)
                triggerComponents.hour = eventComponents.hour
                triggerComponents.minute = eventComponents.minute
            }

        triggerComponents.second = 0

        guard let finalTriggerDate = Calendar.current.date(from: triggerComponents) else {
            print("Could not create final trigger date")
            return
        }

        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerComponents, repeats: false)

        let request = UNNotificationRequest(identifier: event.id, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error)")
            } else {
                print("Notification scheduled for \(event.name) at \(finalTriggerDate)")
            }
        }
    }
    
    func removeAllPendingNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        print("All pending notifications removed")
    }
    
    func unscheduleEventReminder(for event: Event) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [event.id])
        print("Notification unscheduled for \(event.name)")
    }
    
    func updateLastAppOpenDate() {
        UserDefaults.standard.set(Date(), forKey: notificationKey)
    }
}
