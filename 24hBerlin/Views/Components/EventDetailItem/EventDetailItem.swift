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
    
    private let directionsPadding: CGFloat = 12
    
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
                
                HStack {
                    Image(systemName: "road.lanes")
                        .font(.title3)
                        .fontWeight(.heavy)
                    
                    Text("directions")
                        .font(.title3)
                        .fontWeight(.heavy)
                        .foregroundStyle(.black)
                        .maxWidth(.leading)
                    
                    Spacer()
                    
                    Button {
                        mapVM.openMaps(coordinate: coordinate, name: event.name)
                    } label: {
                        Image(systemName: "chevron.right")
                            .bold()
                            .font(.footnote)
                            .foregroundStyle(.white)
                            .padding(directionsPadding)
                            .background(Circle().fill(.blue))
                            .shadow(color: .gray.opacity(0.3), radius: 2, x: 0, y: 2)
                    }  
                }
                .padding(.vertical, directionsPadding)
                .padding(.horizontal, regularPadding)
                .maxWidth(.leading)
                .background(.white)
                .overlay(
                    RoundedRectangle(cornerRadius: mediumRounding)
                        .stroke(.details, lineWidth: 1)
                )
                
                HStack {
                    Map(initialPosition: .region(.init(
                        center: coordinate,
                        span: .init(
                            latitudeDelta: 0.005,
                            longitudeDelta: 0.005
                        )
                    ))) {
                        Marker(coordinate: coordinate) {
                            Label(
                                event.name,
                                systemImage: event.eventType != nil
                                ? event.eventType!.values.contains("Konzert")
                                ? "music.microphone" : event.eventType!.values.contains("Party")
                                ? "hifispeaker" : "photo.on.rectangle.angled" : "mappin"
                            )
                        }
                        .tint((event.eventType?.values.contains("Konzert") ?? true)
                              ? .concert : (event.eventType?.values.contains("Party") ?? false)
                              ? .party : .artAndCulture)
                    }
                    .tint(.blue)
                    .mapControls {
                        MapCompass()
                        MapUserLocationButton()
                        MapScaleView()
                        MapPitchToggle()
                    }
                }
                .maxWidth()
                .frame(height: 120)
                .background(.details)
                .clipShape(.rect(cornerRadius: mediumRounding))
                
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
