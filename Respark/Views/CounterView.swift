//
//  CounterView.swift
//  Respark
//
//  Created by Mateusz Ficek on 12/12/2024.
//

import SwiftUI

struct CounterView: View {
    @ObservedObject var cycleManager: CycleManager
    @Binding var tab: Tab
    @State var progressAmount: Double = 1.00

    var body: some View {
        ZStack {
            PrimaryBackgroundView(progressAmount: progressAmount)

            VStack {
                HStack {
                    MenuButtonView(icon: "line.3.horizontal", width: 30, height: 16, action: {
                        withAnimation(.easeOut(duration: 1/2)) {
                            tab = .settings
                        }
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
                    ActionButtonView(icon: cycleManager.isRunning ? "pause.circle.fill" : "play.circle.fill", action: {
                        if cycleManager.isRunning {
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
            }.onChange(of: cycleManager.getRemainingCyclePercentage()) { newProgress, _ in
                withAnimation(.linear(duration: 1)) {
                    progressAmount = newProgress
                }
            }
        }
    }

    private func startTimer() {
        cycleManager.isRunning = true
        cycleManager.startTimer()
    }

    private func stopTimer() {
        cycleManager.isRunning = false
        cycleManager.stopTimer()
    }
}

#Preview {}
