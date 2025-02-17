//
//  ViewExtension.swift
//  24hBerlin
//
//  Created by Emanuel Sutor on 28.01.25.
//

import SwiftUI

extension View {
    func appTitleStyle() -> some View {
        self.font(.title)
            .fontWeight(.heavy)
            .foregroundStyle(.black)
            .multilineTextAlignment(.center)
            .lineLimit(2, reservesSpace: true)
            .padding(.top, largePadding)
    }
    
    func confirmationMessageStyle() -> some View {
        self.foregroundStyle(.green)
            .font(.footnote)
            .maxWidth()
    }
    
    func darkButtonStyle() -> some View {
        self.font(.title3)
            .bold()
            .foregroundStyle(.white)
            .maxWidth()
            .padding(regularPadding)
            .background(.black)
            .clipShape(.rect(cornerRadius: slightRounding))
            .shadow(color: .gray.opacity(0.3), radius: 3, x: 0, y: 2)
    }
    
    func detailCardStyle(_ alignment: Alignment = .center) -> some View {
        self.padding(regularPadding)
            .maxWidth(alignment)
            .background(.details)
            .clipShape(.rect(cornerRadius: mediumRounding))
    }
    
    func errorMessageStyle() -> some View {
        self.foregroundStyle(.red)
            .font(.footnote)
            .maxWidth()
    }
    
    func maxHeight(_ alignment: Alignment = .center) -> some View {
        self.frame(maxHeight: .infinity, alignment: alignment)
    }
    
    func maxWidth(_ alignment: Alignment = .center) -> some View {
        self.frame(maxWidth: .infinity, alignment: alignment)
    }
    
    func navigationTitleStyle() -> some View {
        self.font(.title)
            .bold()
            .foregroundStyle(.white)
            .padding(.bottom, smallPadding)
    }
    
    func pickerStyle() -> some View {
        self.fontWeight(.medium)
            .lineLimit(1)
    }
    
    func settingsFieldStyle() -> some View {
        self.background(.white)
            .clipShape(.rect(cornerRadius: slightRounding))
            .shadow(color: .gray.opacity(0.3), radius: 3, x: 0, y: 2)
    }
    
    func toolbarStyle(_ visibility: Visibility = .visible) -> some View {
        self.toolbarBackground(.black, for: .navigationBar)
            .toolbarBackgroundVisibility(.visible, for: .navigationBar)
            .toolbarBackground(.black, for: .tabBar)
            .toolbarBackgroundVisibility(visibility, for: .tabBar)
    }
}
