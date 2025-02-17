//
//  Categories.swift
//  24hBerlin
//
//  Created by Emanuel Sutor on 23.01.25.
//

import SwiftUI

struct Categories: View {
    var eventType: [String: String]?
    var sounds: [String: String]?
    
    var body: some View {
        if let eventType {
            HStack(alignment: .top) {
                Text("types")
                    .italic()
                    .foregroundStyle(.white.opacity(0.8))
                
                Text(LocalizedStringKey(eventType.values.joined(separator: ", ")))
            }
            .textSelection(.enabled)
        }
        
        if let sounds {
            HStack(alignment: .top) {
                Text("sounds")
                    .italic()
                    .foregroundStyle(.white.opacity(0.8))
                
                Text(sounds.values.joined(separator: ", "))
            }
            .textSelection(.enabled)
        }
    }
}
