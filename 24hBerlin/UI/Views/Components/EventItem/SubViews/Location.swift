//
//  Location.swift
//  24hBerlin
//
//  Created by Emanuel Sutor on 23.01.25.
//

import SwiftUI

struct Location: View {
    var locationName: String?
    var address: String?
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            if let locationName {
                Image(systemName: "mappin.and.ellipse")
                    .bold()
                    .padding(.trailing, mediumPadding)
                
                VStack(alignment: .leading) {
                    Text(locationName.replacingOccurrences(of: "amp;", with: ""))
                        .padding(.top, 3)
                    
                    if let address {
                        let parts = address.split(separator: ", ")
                        ForEach(parts, id: \.self) { part in
                            Text(part)
                        }
                    }
                }
                .textSelection(.enabled)
            }
        }
    }
}
