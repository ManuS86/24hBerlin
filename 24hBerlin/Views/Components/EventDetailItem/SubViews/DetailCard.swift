//
//  Details.swift
//  24hBerlin
//
//  Created by Emanuel Sutor on 23.01.25.
//

import SwiftUI

struct DetailCard: View {
    var details: String
    
    var body: some View {
        if details != "" {
            HStack(alignment: .top) {
                Image(systemName: "line.3.horizontal")
                    .bold()
                    .foregroundStyle(.party)
                    .padding(.top, 3)
                
                VStack(alignment: .leading)  {
                    Text("event_details")
                        .bold()
                        .foregroundStyle(.black)
                        .padding(.bottom, smallPadding)
                    
                    Text(details
                        .replacingOccurrences(of: "<.*?>", with: "", options: .regularExpression)
                        .replacingOccurrences(of: "&amp;", with: "")
                        .replacingOccurrences(of: "&slig;", with: "ß")
                        .replacingOccurrences(of: "&auml;", with: "ä")
                        .replacingOccurrences(of: "&ouml;", with: "ö")
                        .replacingOccurrences(of: "&uuml;", with: "ü")
                        .replacingOccurrences(of: "&ndash;", with: "-"))
                }
                .textSelection(.enabled)
            }
            .detailCardStyle()
        }
    }
}
