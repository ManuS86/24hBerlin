//
//  Event.swift
//  24hBerlin
//
//  Created by Emanuel Sutor on 19.12.24.
//

import SwiftUI

struct EventItem: View {
    @EnvironmentObject private var eventVM: EventViewModel
    @State private var showDetail: Bool = false
    
    var event: Event
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .top) {
                ImageAndDate(
                    imageURL: event.imageURL,
                    start: event.start,
                    end: event.end
                )
                
                VStack(alignment: .leading, spacing: mediumPadding) {
                    Header(
                        name: event.name,
                        permalink: event.permalink,
                        subtitle: event.subtitle
                    )
                    Categories(
                        eventType: event.eventType,
                        sounds: event.sounds
                    )
                    Time(
                        start: event.start,
                        end: event.end
                    )
                    Location(
                        locationName: event.locationName,
                        address: event.address
                    )
                    
                    if let user = eventVM.currentUser {
                        var isFavorite: Bool {
                            user.favoriteIDs.contains(event.id)
                        }
                        
                        Button(action: {
                            if isFavorite {
                                eventVM.removeFavoriteID(favoriteID: event.id)
                            } else {
                                eventVM.addFavoriteID(favoriteID: event.id)
                            }
                        }) {
                            Image(systemName: isFavorite ? "star.fill" : "star")
                                .imageScale(.large)
                        }
                        .buttonStyle(.borderless)
                        .padding(.top, -regularPadding)
                        .maxWidth(.bottomTrailing)
                    }
                }
                .font(.subheadline)
            }
            .fontWeight(.semibold)
            .foregroundStyle(.white)
            .padding(regularPadding)
            .maxWidth(.topLeading)
            .background((event.eventType?.values.contains("Konzert") ?? true)
                        ? .concert : (event.eventType?.values.contains("Party") ?? false)
                        ? .party : .artAndCulture)
            .onTapGesture {
                showDetail.toggle()
            }
            
            if showDetail == true {
                EventDetailItem(showDetail: $showDetail, event: event)
                    .environmentObject(MapViewModel())
            }
        }
        .background(.white)
        .clipShape(.rect(cornerRadius: mediumRounding))
        .overlay(
            RoundedRectangle(cornerRadius: mediumRounding)
                .stroke(.black, lineWidth: 0.5)
        )
    }
}
