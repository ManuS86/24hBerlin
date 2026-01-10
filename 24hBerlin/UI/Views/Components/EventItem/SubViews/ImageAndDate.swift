//
//  ImageAndDate.swift
//  24hBerlin
//
//  Created by Emanuel Sutor on 23.01.25.
//

import SwiftUI

struct ImageAndDate: View {
    var imageURL: String?
    var start: Date
    var end: Date?
    
    var body: some View {
        VStack {
            if let imageURL {
                AsyncImage(url: URL(string: imageURL)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Image(systemName: "photo.fill")
                        .font(.title2)
                        .background(
                            RoundedRectangle(cornerRadius: mediumRounding)
                                .stroke(.gray, lineWidth: 0.5)
                        )
                }
                .frame(width: eventImageSize, height: eventImageSize)
                .clipShape(.rect(cornerRadius: mediumRounding))
            }
            
            HStack(alignment: .top, spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    Text(LocalizedStringKey(start.formatted(Date.FormatStyle().weekday(.abbreviated)).uppercased()))
                        .font(.caption2)
                        .offset(y: 3)
                    
                    Text(start.formatted(Date.FormatStyle().day(.twoDigits)))
                        .font(.title)
                    
                    Text(LocalizedStringKey(start.formatted(Date.FormatStyle().month(.abbreviated)).uppercased()))
                        .font(.caption2)
                        .offset(y: -2)
                }
                .padding(.leading, smallPadding)
                
                if let end, end.formatted(date: .numeric, time: .omitted) != start.formatted(date: .numeric, time: .omitted) {
                    HStack(alignment: .center, spacing: 0) {
                        Text("-")
                            .font(.callout)
                            .padding(.top, mediumPadding)
                        
                        VStack(alignment: .leading, spacing: 0) {
                            Text(LocalizedStringKey(end.formatted(Date.FormatStyle().weekday(.abbreviated)).uppercased()))
                                .font(.system(size: 8))
                                .offset(y: 2)
                                .padding(.top, 2)
                            
                            Text(end.formatted(Date.FormatStyle().day(.twoDigits)))
                                .font(.callout)
                        }
                    }
                }
            }
            .frame(width: eventImageSize, alignment: .leading)
            .fontWeight(.black)
        }
        .padding(.trailing, mediumPadding)
    }
}
