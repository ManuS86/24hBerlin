//
//  BugReportView.swift
//  24hBerlin
//
//  Created by Emanuel Sutor on 03.02.25.
//

import SwiftUI

struct BugReportView: View {
    @Binding var showingBugReport: Bool
    @EnvironmentObject private var settingsVM: SettingsViewModel
    @FocusState var isFocused: Bool
    @State private var showingAlert: Bool = false
    @State private var alertMessage: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("report_a_bug")
                .bold()
                .font(.title3)
                .foregroundStyle(.black)
                .padding(.bottom, mediumPadding)
            
            TextEditor(text: $settingsVM.bugMessage)
                .frame(height: 200)
                .padding(regularPadding)
                .background(.white)
                .clipShape(.rect(cornerRadius: slightRounding))
                .focused($isFocused)
                .overlay(
                    RoundedRectangle(cornerRadius: slightRounding)
                        .stroke(isFocused ? .gray : .gray.opacity(0.5), lineWidth: 1)
                )
            
            Button("send_bug_report") {
                if settingsVM.bugMessage.isEmpty {
                    alertMessage = "please_describe_the_bug."
                    showingAlert = true
                } else {
                    settingsVM.sendBugReport() { error in
                        if let error = error {
                            alertMessage = error.localizedDescription
                            showingAlert = true
                        } else {
                            alertMessage = "thank_you_for_your_report!"
                            showingAlert = true
                            settingsVM.bugMessage = ""
                        }
                    }
                }
            }
            .alert(isPresented: $showingAlert) {
                Alert(
                    title: Text("bug_report"),
                    message: Text(LocalizedStringKey(alertMessage)),
                    dismissButton: .default(Text("OK"), action: {
                        if alertMessage == "thank_you_for_your_report!" {
                            showingBugReport = false
                        }
                    })
                )
            }
            .darkButtonStyle()
            .padding(.vertical, largePadding)
        }
        .maxHeight()
        .padding(regularPadding)
        .background(
            Image("background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        )
    }
}
