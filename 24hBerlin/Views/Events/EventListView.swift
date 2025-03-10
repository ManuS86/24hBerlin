//
//  EventsListView.swift
//  24hBerlin
//
//  Created by Emanuel Sutor on 19.12.24.
//

import SwiftUI

struct EventListView: View {
    @Environment(\.scenePhase) var scenePhase
    @EnvironmentObject private var eventVM: EventViewModel
    @EnvironmentObject private var mapVM: MapViewModel
    @EnvironmentObject private var settingsVM: SettingsViewModel
    @StateObject var connectivityMonitor = ConnectivityMonitor()
    @State private var searchText: String = ""
    @State private var selectedEventType: EventType?
    @State private var selectedMonth: Month?
    @State private var selectedSound: String?
    @State private var selectedVenue: String?
    
    private var filteredEvents: [Event] {
        var filteredEvents = eventVM.events
        
        if let selectedMonth = selectedMonth,
           let selectedMonthDate = Calendar.current.date(from: DateComponents(
                year: Calendar.current.component(.year, from: Date()),
                month: selectedMonth.rawValue, day: 1
           )) {
            filteredEvents = filteredEvents.filter { event in
                Calendar.current.isDate(event.start, inSameDayAs: selectedMonthDate)
            }
        }
        
        if let selectedEventType = selectedEventType {
            filteredEvents = filteredEvents.filter { event in
                event.eventType?.values.contains(where: { $0 == selectedEventType.rawValue }) ?? false
            }
        }
        
        if let selectedSound = selectedSound {
            filteredEvents = filteredEvents.filter { event in
                event.sounds?.values.contains(selectedSound) ?? false
            }
        }
        
        if let selectedVenue = selectedVenue {
            filteredEvents = filteredEvents.filter { event in
                event.locationName?.contains(selectedVenue) ?? false
            }
        }
        
        if !searchText.isEmpty {
            filteredEvents = filteredEvents.filter { event in
                event.name.localizedCaseInsensitiveContains(searchText)
            }
        }
        return filteredEvents
    }
    
    var body: some View {
        VStack(spacing: 0) {
            FilterBar(
                selectedEventType: $selectedEventType,
                selectedMonth: $selectedMonth,
                selectedSound: $selectedSound,
                selectedVenue: $selectedVenue,
                sounds: eventVM.uniqueSounds,
                venues: eventVM.uniqueLocations
            )
            
            if !connectivityMonitor.isConnected {
            Image(systemName: "wifi.slash")
                .foregroundColor(.gray)
                .font(.largeTitle)
                .maxHeight()
                .maxWidth()
            } else {
                ScrollView {
                    LazyVStack {
                        ForEach(filteredEvents) { event in
                            EventItem(event: event)
                                .environmentObject(eventVM)
                                .listRowSeparator(.hidden)
                                .listRowBackground(
                                    Image("background")
                                        .resizable()
                                        .scaledToFill()
                                )
                        }
                    }
                    .padding(.vertical, mediumPadding)
                    .padding(.horizontal, regularPadding)
                }
                .scrollIndicators(.hidden)
                .searchable(text: $searchText,prompt: "search_event_names")
                .task {
                    eventVM.loadEvents()
                }
            }
        }
        .background(
            Image("background")
                .resizable()
                .scaledToFill()
        )
        .onAppear {
            if settingsVM.pushNotificationsEnabled {
                eventVM.setupAbsenceReminder()
            }
        }
        .onChange(of: scenePhase) {
            if scenePhase == .active {
                if settingsVM.pushNotificationsEnabled {
                    eventVM.setupAbsenceReminder()
                }
            }
        }
    }
}
