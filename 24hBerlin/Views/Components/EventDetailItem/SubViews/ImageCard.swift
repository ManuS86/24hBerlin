//
//  Image.swift
//  24hBerlin
//
//  Created by Emanuel Sutor on 23.01.25.
//

import SwiftUI

struct ImageCard: View {
    var imageURL: String?
    
    private let imageSize: CGFloat = 180
    
    var body: some View {
        if let imageURL {
            AsyncImage(url: URL(string: imageURL)) { image in
                Rectangle()
                    .frame(height: imageSize)
                    .overlay{
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .allowsHitTesting(false)
                    }
            } placeholder: {
                Image(systemName: "photo.fill")
                    .font(.largeTitle)
                    .maxWidth()
                    .frame(height: imageSize)
                    .background(
                        RoundedRectangle(cornerRadius: mediumRounding)
                            .stroke(.gray, lineWidth: 0.5)
                    )
            }
            .clipShape(.rect(cornerRadius: mediumRounding))
        }
    }
}
