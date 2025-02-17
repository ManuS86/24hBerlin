//
//  LinkDetail.swift
//  24hBerlin
//
//  Created by Emanuel Sutor on 23.01.25.
//

import SwiftUI

struct LearnmoreLinkCard: View {
    var link: String?
    
    var body: some View {
        if let link {
            HStack(alignment: .top) {
                Image(systemName: "link")
                    .bold()
                    .foregroundStyle(.party)
                
                Link("further_information", destination: URL(string: link)!)
                    .fontWeight(.heavy)
                    .foregroundStyle(.black)
                    .maxWidth(.leading)
                    .lineLimit(2)
            }
            .detailCardStyle()
        }
    }
}
