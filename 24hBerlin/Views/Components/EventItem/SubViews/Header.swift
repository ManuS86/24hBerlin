//
//  Header.swift
//  24hBerlin
//
//  Created by Emanuel Sutor on 23.01.25.
//

import SwiftUI

struct Header: View {
    var name: String
    var permalink: String
    var subtitle: String?
    
    var body: some View {
        HStack(alignment: .top) {
            Text(name.uppercased())
                .fontWeight(.black)
                .font(.title2)
                .textSelection(.enabled)
            
            Spacer()
            
            ShareLink(items: [URL(string: permalink)!]) {
                Image(systemName: "square.and.arrow.up")
                    .font(.body)
            }
            .buttonStyle(.borderless)
        }
        
        if let subtitle {
            Text(subtitle.replacingOccurrences(of: "amp;", with: "").uppercased())
                .imageScale(.medium)
                .fontWeight(.semibold)
                .textSelection(.enabled)
        }
    }
}
