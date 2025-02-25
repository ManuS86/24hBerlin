//
//  EventItemDetailView.swift
//  24hBerlin
//
//  Created by Emanuel Sutor on 09.01.25.
//

import MapKit
import SwiftUI

struct EventDetailItem: View {
    @EnvironmentObject private var mapVM: MapViewModel
    @Binding var showDetail: Bool
    
    var event: Event
    
    var body: some View {
        VStack(alignment: .leading) {
            ImageCard(imageURL: event.imageURL)
            DetailCard(details: event.details)
            TimeCard(start: event.start, end: event.end)
            EntranceFeeCard(entranceFee: event.entranceFee)
            LocationCard(
                locationName: event.locationName,
                address: event.address
            )
            LearnmoreLinkCard(link: event.learnmoreLink)
            
            if let lat = event.lat, let lon = event.lon {
                let coordinate = CLLocationCoordinate2D(
                    latitude: lat,
                    longitude: lon
                )
                
                DirectionsCard(onClick: {
                    mapVM.openMaps(coordinate: coordinate, name: event.name)
                })
                
                MapCard(coordinate: coordinate, name: event.name, eventType: event.eventType)
                
                if showDetail {
                    Image(systemName: "chevron.up")
                        .foregroundStyle(.gray)
                        .padding(mediumPadding)
                        .frame(maxWidth: .infinity)
                        .background(.details)
                        .clipShape(.rect(cornerRadius: mediumRounding))
                        .onTapGesture {
                            showDetail.toggle()
                        }
                }
            }
        }
        .padding(mediumPadding)
        .foregroundStyle(.font)
        .font(.callout)
    }
}
