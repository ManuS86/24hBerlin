//
//  MapCard.swift
//  24hBerlin
//
//  Created by Emanuel Sutor on 25.02.25.
//

import MapKit
import SwiftUI

struct MapCard: View {
    var coordinate: CLLocationCoordinate2D
    var name: String
    var eventType: [String: String]?
    
    var body: some View {
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
                        name,
                        systemImage: eventType != nil
                        ? eventType!.values.contains("Konzert")
                        ? "music.microphone" : eventType!.values.contains("Party")
                        ? "hifispeaker" : "photo.on.rectangle.angled" : "mappin"
                    )
                }
                .tint((eventType?.values.contains("Konzert") ?? true)
                      ? .concert : (eventType?.values.contains("Party") ?? false)
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
    }
}
