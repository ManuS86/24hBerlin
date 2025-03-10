//
//  FilterBar.swift
//  24hBerlin
//
//  Created by Emanuel Sutor on 21.01.25.
//

import SwiftUI

struct FilterBar: View {
    @Binding var selectedEventType: EventType?
    @Binding var selectedMonth: Month?
    @Binding var selectedSound: String?
    @Binding var selectedVenue: String?
    @State private var showFilters: Bool = false
    
    var sounds: [String]
    var venues: [String]
    
    var body: some View {
        VStack {
            HStack(spacing: mediumPadding) {
                ScrollView (.horizontal) {
                    LazyHStack(spacing: mediumPadding) {
                        Button {
                            selectedMonth = nil
                        } label: {
                            Text("all")
                                .font(.system(size: 12))
                                .fontWeight(.semibold)
                        }
                        .buttonStyle(.bordered)
                        .tint(selectedMonth == nil ? .white : .gray)
                        
                        ForEach(Month.allCases) { month in
                            Button {
                                selectedMonth = month
                            } label: {
                                Text(LocalizedStringKey(month.englishName))
                                    .font(.system(size: 12))
                                    .fontWeight(.semibold)
                            }
                            .buttonStyle(.bordered)
                            .tint(selectedMonth == month ? .white : .white.opacity(0.6))
                        }
                    }
                }
                .scrollIndicators(.hidden)
                .frame(height: 30)
                
                Image(systemName: "slider.horizontal.3")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(.white)
                    .onTapGesture {
                        showFilters.toggle()
                    }
            }
            .padding(.horizontal, regularPadding)
            .padding(.bottom, smallPadding)
            
            if showFilters {
                HStack {
                    ScrollView(.horizontal) {
                    HStack(spacing: 12) {
                        Menu {
                            Picker("Type", selection: $selectedEventType) {
                                Text("type")
                                    .tag(nil as EventType?)
                                
                                ForEach(EventType.allCases) { eventType in
                                    Text(LocalizedStringKey(eventType.rawValue))
                                        .tag(eventType)
                                }
                            }
                        } label: {
                            HStack(spacing: smallPadding) {
                                if let selectedEventType = selectedEventType {
                                    Text(LocalizedStringKey(selectedEventType.rawValue))
                                        .pickerStyle()
                                } else {
                                    Text("type")
                                        .foregroundStyle(.gray)
                                        .pickerStyle()
                                }
                                
                                Image(systemName: "chevron.down")
                                    .font(.footnote)
                                    .fontWeight(.semibold)
                            }
                            .padding(.horizontal, mediumPadding)
                            .padding(.vertical, smallPadding)
                            .overlay(
                                RoundedRectangle(cornerRadius: slightRounding)
                                    .stroke(.gray, lineWidth: 1)
                            )
                            .padding(.bottom, smallPadding)
                        }
                        
                        Menu {
                            Picker("Sound", selection: $selectedSound) {
                                Text("sound")
                                    .tag(nil as String?)
                                
                                ForEach(sounds, id: \.self) { sound in
                                    Text(sound)
                                        .tag(sound)
                                }
                            }
                        } label: {
                            HStack(spacing: smallPadding) {
                                if let selectedSound = selectedSound {
                                    Text(selectedSound)
                                        .pickerStyle()
                                } else {
                                    Text("sound")
                                        .foregroundStyle(.gray)
                                        .pickerStyle()
                                }
                                
                                Image(systemName: "chevron.down")
                                    .font(.footnote)
                                    .fontWeight(.semibold)
                            }
                            .padding(.horizontal, mediumPadding)
                            .padding(.vertical, smallPadding)
                            .overlay(
                                RoundedRectangle(cornerRadius: slightRounding)
                                    .stroke(.gray, lineWidth: 1)
                            )
                            .padding(.bottom, smallPadding)
                        }
                        
                        Menu {
                            Picker("Venue", selection: $selectedVenue) {
                                Text("venue_")
                                    .tag(nil as String?)
                                
                                ForEach(venues, id: \.self) { venue in
                                    Text(venue.replacingOccurrences(of: "amp;", with: ""))
                                        .tag(venue)
                                }
                            }
                        } label: {
                            HStack(spacing: smallPadding) {
                                if let selectedVenue = selectedVenue {
                                    Text(selectedVenue.replacingOccurrences(of: "amp;", with: ""))
                                        .pickerStyle()
                                } else {
                                    Text("venue_")
                                        .foregroundStyle(.gray)
                                        .pickerStyle()
                                }
                                
                                Image(systemName: "chevron.down")
                                    .font(.footnote)
                                    .fontWeight(.semibold)
                            }
                            .padding(.horizontal, mediumPadding)
                            .padding(.vertical, smallPadding)
                            .overlay(
                                RoundedRectangle(cornerRadius: slightRounding)
                                    .stroke(.gray, lineWidth: 1)
                            )
                            .padding(.bottom, smallPadding)
                        }
                    }
                    .scrollIndicators(.hidden)
                }
                    
                    if selectedEventType != nil
                        || selectedSound != nil
                        || selectedVenue != nil {
                        Spacer()
                        
                        Image(systemName: "xmark.circle")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .onTapGesture {
                                selectedEventType = nil
                                selectedSound = nil
                                selectedVenue = nil
                            }
                    }
                }
                .maxWidth(.leading)
                .padding(.horizontal, regularPadding)
                .padding(.top, 1)
            }
        }
        .padding(.bottom, mediumPadding)
        .background(.black)
    }
}
