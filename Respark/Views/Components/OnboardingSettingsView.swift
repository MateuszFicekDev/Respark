//
//  OnboardingSettingsView.swift
//  Respark
//
//  Created by Mateusz Ficek on 26/11/2024.
//

import SwiftUI

struct OnboardingSettingsView: View {
    @State var workTimeMinutes: Int = 25
    @State var longBreakTimeMinutes: Int = 10
    @State var shortBreakTimeMinutes: Int = 5

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
        }
        .padding(.vertical, 64)
        .padding(.horizontal, 32)
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
