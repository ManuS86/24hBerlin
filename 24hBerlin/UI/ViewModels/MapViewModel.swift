//
//  Untitled.swift
//  24hBerlin
//
//  Created by Emanuel Sutor on 03.01.25.
//

import Contacts
import MapKit
import SwiftUI

class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var origin: CLLocationCoordinate2D?
    @Published var position: MapCameraPosition = .automatic
    
    private var locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.origin = locations.last?.coordinate
        position = .region(.init(center: origin!, span: .init(latitudeDelta: 0.01, longitudeDelta: 0.01)))
    }
    
    func openMaps(coordinate: CLLocationCoordinate2D, name: String?) {
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate))
        mapItem.name = name

        let launchOptions: [String: Any]? = nil

        if mapItem.responds(to: #selector(mapItem.openInMaps(launchOptions:))) {
            mapItem.openInMaps(launchOptions: launchOptions)
        } else {
            guard let mapURL = mapItem.url else { return }
            UIApplication.shared.open(mapURL)
        }
    }
    
    func requestLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}
