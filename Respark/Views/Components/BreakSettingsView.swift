//
//  BreakSettingsView.swift
//  Respark
//
//  Created by Mateusz Ficek on 27/11/2024.
//

import SwiftUI

struct BreakSettingsView: View {
    @State var breakCount: Double = UserPreferences.shared.getLongBreakInterval()

    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text("Push Through or Take a Break?")
                    .font(.title)
                    .bold()
                    .padding(.bottom, 8)

                Text("Stay productive while avoiding burnout. Set the number of cycles to power through before your next big recharge.")
            }

            Spacer()
            VStack(alignment: .center) {
                Text("Number of Cycles")
                    .font(.headline)
                    .bold()
                Text(String(format: "%.0f", breakCount))
                    .font(.title)
                    .padding(.all, 24)

                Slider(value: $breakCount,
                       in: 1 ... 10,
                       step: 1,
                       label: { Text("\(breakCount) cycles") },
                       minimumValueLabel: { Text("1").padding() },
                       maximumValueLabel: { Text("10").padding() })
                    .tint(breakCount < 5 ? .primaryBlue : breakCount < 8 ? .primaryYellow : .primaryOrange)
                    .padding()
                    .onChange(of: breakCount) { _, _ in UserPreferences.shared.saveLongBreakInterval(longBreakInterval: breakCount)
                    }

                Text("After \(Int(breakCount)) work cycle\(breakCount > 1 ? "s" : "") you will take a longer break.")
                    .fontWeight(.light)
                    .multilineTextAlignment(.center)
            }
        }
        .padding(.vertical, 64)
        .padding(.horizontal, 32)
    }
}

#Preview {
    BreakSettingsView()
}
