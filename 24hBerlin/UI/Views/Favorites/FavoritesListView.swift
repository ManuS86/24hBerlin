//
//  FavoritesView.swift
//  24hBerlin
//
//  Created by Emanuel Sutor on 19.12.24.
//

import SwiftUI

struct FavoritesListView: View {
    @EnvironmentObject private var eventVM: EventViewModel
    @EnvironmentObject private var mapVM: MapViewModel
    @State private var searchText: String = ""
    @State private var selectedEventType: EventType?
    @State private var selectedMonth: Month?
    @State private var selectedSound: String?
    @State private var selectedVenue: String?
    @State private var showFilters: Bool = false
    
    private var filteredFavorites: [Event] {
        var filteredFavorites = eventVM.favorites
        
        if let selectedMonth = selectedMonth,
           let selectedMonthDate = Calendar.current.date(from: DateComponents(
                year: Calendar.current.component(.year, from: Date()),
                month: selectedMonth.rawValue, day: 1
           )) {
            filteredFavorites = filteredFavorites.filter { event in
                Calendar.current.isDate(event.start, inSameDayAs: selectedMonthDate)
            }
        }
        
        if let selectedEventType = selectedEventType {
            filteredFavorites = filteredFavorites.filter { event in
                event.eventType?.values.contains(where: { $0 == selectedEventType.rawValue }) ?? false
            }
        }
        
        if let selectedSound = selectedSound {
            filteredFavorites = filteredFavorites.filter { event in
                event.sounds?.values.contains(selectedSound) ?? false
            }
        }
        
        if let selectedVenue = selectedVenue {
            filteredFavorites = filteredFavorites.filter { event in
                event.locationName?.contains(selectedVenue) ?? false
            }
        }
        
        if !searchText.isEmpty {
            filteredFavorites = filteredFavorites.filter { event in
                event.name.localizedCaseInsensitiveContains(searchText)
            }
        }
        return filteredFavorites
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
            
            ScrollView {
                LazyVStack {
                    ForEach(filteredFavorites) { event in
                        EventItem(event: event)
                            .environmentObject(eventVM)
                            .environmentObject(mapVM)
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
        .background(
            Image("background")
                .resizable()
                .scaledToFill()
        )
    }
}

#Preview {
    FavoritesListView()
        .environmentObject(EventViewModel())
        .environmentObject(MapViewModel())
}
