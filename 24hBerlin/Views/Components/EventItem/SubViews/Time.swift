//
//  Time.swift
//  24hBerlin
//
//  Created by Emanuel Sutor on 23.01.25.
//

import SwiftUI

struct Time: View {
    var start: Date
    var end: Date?
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            Image(systemName: "clock.fill")
                .padding(.trailing, mediumPadding)
            
            Text(start.formatted(date: .omitted, time: .shortened))
            if let end {
                Text(" - ")
                Text(end.formatted(date: .omitted, time: .shortened))
            }
        }
        .textSelection(.enabled)
    }
}
