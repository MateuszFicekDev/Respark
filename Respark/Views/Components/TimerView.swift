//
//  TimerView.swift
//  Respark
//
//  Created by Mateusz Ficek on 29/11/2024.
//

import SwiftUI

struct TimerView: View {
    let totalSeconds: Int

    var body: some View {
        Text(formattedTime)
            .font(.system(size: 64, weight: .bold, design: .monospaced))
            .padding()
            .contentTransition(.numericText(countsDown: true))
    }

    private var formattedTime: String {
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

#Preview {
    TimerView(totalSeconds: 1210)
}
