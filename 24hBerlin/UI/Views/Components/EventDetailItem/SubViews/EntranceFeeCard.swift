//
//  EntranceFeeItem.swift
//  24hBerlin
//
//  Created by Emanuel Sutor on 23.01.25.
//

import SwiftUI

struct EntranceFeeCard: View {
    var entranceFee: EntranceFee?
    
    var body: some View {
        if let entranceFee {
            HStack(alignment: .top) {
                Image(systemName: "eurosign.square.fill")
                    .bold()
                    .foregroundStyle(.party)
                
                VStack(alignment: .leading) {
                    Text("entrance_fee")
                        .bold()
                        .foregroundStyle(.black)
                        .padding(.bottom, smallPadding)
                    
                    Text(entranceFee.value.replacingOccurrences(of: "<br>", with: "\n").replacingOccurrences(of: "<.*?>", with: "", options: .regularExpression))
                }
                .textSelection(.enabled)
            }
            .detailCardStyle(.leading)
        }
    }
}
