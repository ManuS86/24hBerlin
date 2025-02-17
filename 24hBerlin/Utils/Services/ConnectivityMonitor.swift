//
//  ConnectivityMonitor.swift
//  24hBerlin
//
//  Created by Emanuel Sutor on 30.01.25.
//


import SwiftUI
import Network

class ConnectivityMonitor: ObservableObject {
    private let monitor = NWPathMonitor()
    @Published var isConnected: Bool = true

    init() {
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isConnected = path.status == .satisfied
            }
        }
        monitor.start(queue: DispatchQueue.global(qos: .userInitiated))
    }

    deinit {
        monitor.cancel()
    }
}
