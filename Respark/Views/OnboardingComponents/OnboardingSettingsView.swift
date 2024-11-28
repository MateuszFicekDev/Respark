//
//  OnboardingSettingsView.swift
//  Respark
//
//  Created by Mateusz Ficek on 26/11/2024.
//

import SwiftUI

struct OnboardingSettingsView: View {
    @State var workTimeMinutes: Int = UserPreferences.shared.getWorkDuration()
    @State var longBreakTimeMinutes: Int = UserPreferences.shared.getLongBreakDuration()
    @State var shortBreakTimeMinutes: Int = UserPreferences.shared.getShortBreakDuration()

    var body: some View {
        VStack(alignment: .leading) {
            Text("Set up your preferences")
                .font(.title)
                .bold()
                .padding(.bottom, 8)
            Text("Customize Work and Break Times")
            Spacer()

            PreferenceView(time: $workTimeMinutes, description: "Work time (minutes):")
            PreferenceView(time: $longBreakTimeMinutes, description: "Long break (minutes):")
            PreferenceView(time: $shortBreakTimeMinutes, description: "Short break (minutes):")

            HStack {
                Spacer()
                Image(systemName: "chevron.down.2")
                    .resizable()
                    .frame(width: 32, height: 32)
                Spacer()
            }
        }
        .padding(.vertical, 64)
        .padding(.horizontal, 32)
        .onChange(of: workTimeMinutes) {
            _, _ in
            UserPreferences.shared.saveTimeSettings(workDuration: workTimeMinutes, shortBreakDuration: shortBreakTimeMinutes, longBreakDuration: longBreakTimeMinutes)
        }.onChange(of: longBreakTimeMinutes) {
            _, _ in
            UserPreferences.shared.saveTimeSettings(workDuration: workTimeMinutes, shortBreakDuration: shortBreakTimeMinutes, longBreakDuration: longBreakTimeMinutes)
        }.onChange(of: shortBreakTimeMinutes) {
            _, _ in
            UserPreferences.shared.saveTimeSettings(workDuration: workTimeMinutes, shortBreakDuration: shortBreakTimeMinutes, longBreakDuration: longBreakTimeMinutes)
        }
    }
}

struct PreferenceView: View {
    @Binding var time: Int
    let description: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(description)
                .font(.headline)
                .bold()
                .padding(.bottom, 4)
            HStack {
                Spacer()
                Button(action: {
                    if time == 0 { return }
                    time -= 1
                }) {
                    Image(systemName: "minus.circle.fill")
                        .resizable()
                        .symbolRenderingMode(.hierarchical)
                        .foregroundStyle(.black)
                        .frame(width: 64, height: 64)
                }
                Text("\(time)")
                    .font(.system(size: 48))
                    .bold()
                    .padding(.horizontal, 16)
                    .frame(width: 120)

                Button(action: { time += 1 }) {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .symbolRenderingMode(.hierarchical)
                        .foregroundStyle(.black)
                        .frame(width: 64, height: 64)
                }
                Spacer()
            }
        }.padding(.bottom, 36)
    }
}

#Preview {
    OnboardingSettingsView()
}
