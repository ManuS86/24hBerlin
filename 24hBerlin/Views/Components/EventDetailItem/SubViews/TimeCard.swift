//
//  Time.swift
//  24hBerlin
//
//  Created by Emanuel Sutor on 23.01.25.
//

import SwiftUI

struct TimeCard: View {
    var start: Date
    var end: Date?
    
    var body: some View {
        HStack(alignment: .top) {
            Image(systemName: "clock.fill")
                .font(.headline)
                .foregroundStyle(.party)
            
            VStack(alignment: .leading) {
                Text("time")
                    .bold()
                    .foregroundStyle(.black)
                    .padding(.bottom, smallPadding)
                
                HStack(spacing: 0) {
                    Text(start.formatted(date: .numeric, time: .shortened))
                    
                    if let end {
                        Text(" - ")
                        Text(end.formatted(date: .numeric, time: .shortened))
                    }
                }
                .font(.subheadline)
                .maxWidth(.leading)
                .textSelection(.enabled)
            }
        }
        .detailCardStyle()
    }
}
