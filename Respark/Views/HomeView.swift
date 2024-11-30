//
//  HomeView.swift
//  Respark
//
//  Created by Mateusz Ficek on 28/11/2024.
//

import SwiftUI

struct HomeView: View {
    @State private var isRunning: Bool = false // Track if the timer is running
    @State private var timer: Timer? // Reference to the timer
    @StateObject private var cycleManager = CycleManager(workDuration: UserPreferences.shared.getWorkDuration() * 60, shortBreakDuration: UserPreferences.shared.getShortBreakDuration() * 60, longBreakDuration: UserPreferences.shared.getLongBreakDuration() * 60, cyclesBeforeLongBreak: Int(UserPreferences.shared.getLongBreakInterval()))

    @State var progressAmount: Double = 1.00

    var body: some View {
        ZStack {
            PrimaryBackgroundView(progressAmount: progressAmount)

            VStack {
                HStack {
                    MenuButtonView(icon: "line.3.horizontal", width: 30, height: 16, action: {
                        // TODO: handle navigation to settings
                    })

                    Spacer()
                    MenuButtonView(icon: "star.circle.fill", action: {
                        // TODO: handle marking background as favorite
                    })
                }
                Spacer()
                Text(cycleManager.currentPhase.title)
                    .multilineTextAlignment(.center)
                    .font(.title)
                    .padding(.horizontal, 48)

                Text(cycleManager.currentPhase.subtitle)
                    .fontWeight(.thin)

                TimerView(totalSeconds: cycleManager.timeRemaining)
                Spacer()

                HStack {
                    ActionButtonView(icon: isRunning ? "pause.circle.fill" : "play.circle.fill", action: {
                        if isRunning {
                            stopTimer()
                        } else {
                            startTimer()
                        }
                    })

                    ActionButtonView(icon: "arrow.counterclockwise.circle.fill", action: {
                        stopTimer()
                        cycleManager.resetCurrentCycle()
                    })
                }
            }
        }
    }

    private func startTimer() {
        isRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            withAnimation(.linear(duration: 1)) {
                cycleManager.decrementTime()
                progressAmount = cycleManager.getRemainingCyclePercentage()
            }
        }
    }

    private func stopTimer() {
        isRunning = false
        timer?.invalidate()
        timer = nil
    }
}

#Preview {
    HomeView()
}
