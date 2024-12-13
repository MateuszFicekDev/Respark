//
//  SettingsView.swift
//  Respark
//
//  Created by Mateusz Ficek on 12/12/2024.
//

import SwiftUI

struct SettingsView: View {
    @State private var workDuration: Double = .init(UserPreferences.shared.getWorkDuration())
    @State private var shortBreakDuration: Double = .init(UserPreferences.shared.getShortBreakDuration())
    @State private var longBreakDuration: Double = .init(UserPreferences.shared.getLongBreakDuration())
    @ObservedObject var cycleManager: CycleManager

    var body: some View {
        ZStack {
            Color.primaryBackground.ignoresSafeArea()
            VStack(alignment: .leading) {
                Section("Work Duration", content: {
                    VStack {
                        Text("\(Int(workDuration)) min")
                            .font(.largeTitle)
                            .bold()

                        Slider(
                            value: $workDuration,
                            in: 5 ... 180,
                            step: 5
                        )
                        .tint(workDuration < 60.0 ? Color.primaryGreen : workDuration < 120 ? Color.primaryBlue : Color.primaryOrange)
                        .onChange(of: workDuration) { _, _ in
                            saveTimeSettings()
                            cycleManager.updateTimes()
                        }
                    }.padding()
                })

                Section("Short Break Duration", content: {
                    VStack {
                        Text("\(Int(shortBreakDuration)) min")
                            .font(.largeTitle)
                            .bold()

                        Slider(
                            value: $shortBreakDuration,
                            in: 1 ... 30,
                            step: 1
                        )
                        .tint(shortBreakDuration < 10.0 ? Color.primaryGreen : shortBreakDuration < 15 ? Color.primaryBlue : Color.primaryOrange)
                        .onChange(of: shortBreakDuration) { _, _ in
                            saveTimeSettings()
                            cycleManager.updateTimes()
                        }
                    }.padding()
                })

                Section("Long Break Duration", content: {
                    VStack {
                        Text("\(Int(longBreakDuration)) min")
                            .font(.largeTitle)
                            .bold()

                        Slider(
                            value: $longBreakDuration,
                            in: 1 ... 60,
                            step: 1
                        )
                        .tint(longBreakDuration < 15.0 ? Color.primaryGreen : longBreakDuration < 30 ? Color.primaryBlue : Color.primaryOrange)
                        .onChange(of: longBreakDuration) { _, _ in
                            saveTimeSettings()
                            cycleManager.updateTimes()
                        }
                    }.padding()
                })

            }.padding(.all, 36)
        }
    }

    private func saveTimeSettings() {
        UserPreferences.shared
            .saveTimeSettings(
                workDuration: Int(workDuration),
                shortBreakDuration: Int(shortBreakDuration),
                longBreakDuration: Int(longBreakDuration)
            )
    }
}

#Preview {}
