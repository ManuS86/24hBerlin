//
//  LocationDetail.swift
//  24hBerlin
//
//  Created by Emanuel Sutor on 23.01.25.
//

import SwiftUI

struct LocationCard: View {
    var locationName: String?
    var address: String?
    
    var body: some View {
        if let locationName {
            HStack(alignment: .top) {
                Image(systemName: "mappin.and.ellipse")
                    .bold()
                    .foregroundStyle(.party)
                
                VStack(alignment: .leading) {
                    Text("venue")
                        .bold()
                        .foregroundStyle(.black)
                        .padding(.bottom, smallPadding)
                    
                    Text(locationName.replacingOccurrences(of: "amp;", with: ""))
                    
                    if let address {
                        let parts = address.split(separator: ", ")
                        ForEach(parts, id: \.self) { part in
                            Text(part)
                        }
                    }
                }
                .textSelection(.enabled)
            }
            .detailCardStyle(.leading)
        }
    }
}
