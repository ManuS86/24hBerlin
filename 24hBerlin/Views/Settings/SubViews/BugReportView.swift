//
//  BugReportView.swift
//  24hBerlin
//
//  Created by Emanuel Sutor on 03.02.25.
//

import SwiftUI

struct BugReportView: View {
    @Binding var showBugReport: Bool
    @EnvironmentObject private var settingsVM: SettingsViewModel
    @FocusState var isFocused: Bool
    @State private var alertMessage: String = ""
    @State private var showAlert: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("report_a_bug")
                .bold()
                .font(.title3)
                .foregroundStyle(.black)
                .padding(.bottom, mediumPadding)
            
            TextEditor(text: $settingsVM.bugReport)
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
                if settingsVM.bugReport.isEmpty {
                    alertMessage = "please_describe_the_bug."
                    showAlert = true
                } else {
                    settingsVM.sendBugReport() { error in
                        if let error = error {
                            alertMessage = error.localizedDescription
                            showAlert = true
                        } else {
                            alertMessage = "thank_you_for_your_report!"
                            showAlert = true
                            settingsVM.bugReport = ""
                        }
                    }
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("bug_report"),
                    message: Text(LocalizedStringKey(alertMessage)),
                    dismissButton: .default(Text("OK"), action: {
                        if alertMessage == "thank_you_for_your_report!" {
                            showBugReport = false
                        }
                    })
                )
            }
            .darkButtonStyle()
            .padding(.vertical, largePadding)
        }
        .maxHeight()
        .padding(regularPadding)
    }
}
