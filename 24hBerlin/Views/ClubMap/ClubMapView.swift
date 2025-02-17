//
//  ClubMapView.swift
//  24hBerlin
//
//  Created by Emanuel Sutor on 19.12.24.
//

import MapKit
import SwiftUI

struct ClubMapView: View {
    @EnvironmentObject private var eventVM: EventViewModel
    @EnvironmentObject private var mapVM: MapViewModel
    @State private var searchText: String = ""
    @State private var selectedEvent: Event?
    @State private var selectedEventType: EventType?
    @State private var selectedMonth: Month?
    @State private var selectedSound: Sound?
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
                event.sounds?.values.contains(where: { $0 == selectedSound.rawValue }) ?? false
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
                venues: eventVM.uniqueLocations
            )
            
            Map {
                ForEach(filteredEvents) { event in
                    if event.lat != nil && event.lon != nil {
                        let coordinate = CLLocationCoordinate2D(
                            latitude: event.lat!,
                            longitude: event.lon!
                        )
                        
                        Annotation(event.name, coordinate: coordinate) {
                            VStack(spacing: 0) {
                                Image(systemName: event.eventType != nil
                                      ? event.eventType!.values.contains("Konzert")
                                      ? "music.microphone" : event.eventType!.values.contains("Party")
                                      ? "hifispeaker" : "photo.on.rectangle.angled" : "mappin")
                                .font(.title3)
                                .foregroundStyle(.white)
                                .padding(6)
                                .background(
                                    Circle()
                                    .fill((event.eventType?.values.contains("Konzert") ?? true)
                                          ? .concertLight : (event.eventType?.values.contains("Party") ?? false)
                                          ? .partyLight : .artAndCultureLight)
                                )
                                .overlay(
                                    Circle()
                                        .stroke((event.eventType?.values.contains("Konzert") ?? true)
                                                ? .concert : (event.eventType?.values.contains("Party") ?? false)
                                                ? .party : .artAndCulture)
                                )
                                
                                Image(systemName: "triangle.fill")
                                    .rotationEffect(Angle(degrees: 180))
                                    .font(.caption2)
                                    .foregroundStyle((event.eventType?.values.contains("Konzert") ?? true)
                                                     ? .concert : (event.eventType?.values.contains("Party") ?? false)
                                                     ? .party : .artAndCulture)
                                    .offset(y: -5)
                                    .shadow(color: .gray.opacity(0.3), radius: 2, x: 0, y: 2)
                            }
                            .offset(y: 10)
                            .onTapGesture {
                                selectedEvent = event
                            }
                        }
                    }
                }
            }
            .searchable(text: $searchText,prompt: "search_event_names")
            .task {
                mapVM.requestLocation()
            }
            .tint(.blue)
            .mapControls {
                MapCompass()
                MapUserLocationButton()
                MapScaleView()
                MapPitchToggle()
            }
            .sheet(item: $selectedEvent) { event in
                NavigationStack {
                    ScrollView {
                        EventItemExpanded(event: event)
                            .environmentObject(eventVM)
                            .toolbarColorScheme(.dark)
                    }
                    .padding(regularPadding)
                    .scrollIndicators(.hidden)
                    .presentationDragIndicator(.visible)
                    .presentationDetents([.medium, .large])
                    .toolbarBackgroundVisibility(.hidden, for: .navigationBar)
                }
            }
        }
    }
}
