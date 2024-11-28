//
//  AutomationSettingsView.swift
//  Respark
//
//  Created by Mateusz Ficek on 27/11/2024.
//

import SwiftUI

struct AutomationSettingsView: View {
    @State private var isAutoStartEnabled = UserPreferences.shared.getStartStagesAutomatically()
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text("Take Control or Let It Flow")
                    .font(.title)
                    .bold()
                    .foregroundColor(.black)
                    .padding(.bottom, 8)

                Text("Would you like each stage to start automatically, or would you prefer to start them manually?")
                    .foregroundColor(.black)
            }

            Spacer()

            Toggle(
                isAutoStartEnabled ? "Starting Automatically" : "Starting Manually",
                systemImage: isAutoStartEnabled ? "repeat" : "hand.tap",
                isOn: $isAutoStartEnabled
            )
            .foregroundStyle(.black)
            .toggleStyle(.button)
            .tint(.primaryBackground)
            .padding(.bottom, 12)
            .contentTransition(.identity)
            .onChange(of: isAutoStartEnabled) {
                _, _ in
                UserPreferences.shared.saveAutomationSettings(startStagesAutomatically: isAutoStartEnabled)
            }
            if isAutoStartEnabled {
                Text("Next stage will start on its own.")
                    .fontWeight(.light)
                    .foregroundColor(.black)
            } else {
                Text("Each stage will require your confirmation.")
                    .fontWeight(.light)
                    .foregroundColor(.black)
            }

            HStack {
                Spacer()
                Image(systemName: "chevron.down.2")
                    .resizable()
                    .foregroundColor(.black)
                    .frame(width: 32, height: 32)
                Spacer()
            }.padding(.top, 64)
        }
        .padding(.vertical, 64)
        .padding(.horizontal, 32)
    }
}

#Preview {
    AutomationSettingsView()
}
