//
//  DirectionsCard.swift
//  24hBerlin
//
//  Created by Emanuel Sutor on 25.02.25.
//

import SwiftUI

struct DirectionsCard: View {
    var onClick: () -> Void
    
    private let directionsPadding: CGFloat = 12
    
    var body: some View {
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
                onClick()
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
    }
}
