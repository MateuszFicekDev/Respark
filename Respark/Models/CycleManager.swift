//
//  CycleManager.swift
//  Respark
//
//  Created by Mateusz Ficek on 29/11/2024.
//

import AVFoundation
import Foundation

class CycleManager: ObservableObject {
    @Published var currentPhase: CyclePhase = .work // Work or break phase

    @Published var workDuration: Int = UserPreferences.shared.getWorkDuration() * 60
    @Published var shortBreakDuration: Int = UserPreferences.shared.getShortBreakDuration() * 60
    @Published var longBreakDuration: Int = UserPreferences.shared.getLongBreakDuration() * 60
    @Published var cyclesBeforeLongBreak: Int = .init(UserPreferences.shared.getLongBreakInterval())

    @Published var currentCycle: Int = 0
    @Published var isWorkSession: Bool = true
    @Published var timeRemaining: Int = UserPreferences.shared.getWorkDuration() * 60
    @Published var isLongBreak: Bool = false

    @Published var isRunning: Bool = false
    @Published var remainingCyclePercentage: CGFloat = 1.0
    private var timer: Timer?
    private var startCyclesAutomatically: Bool = UserPreferences.shared.getStartStagesAutomatically()
    private var player: AVAudioPlayer?

    init() {}

    func startNextCycle() {
        if isWorkSession {
            currentCycle += 1
        }

        nextPhase()

        // Check if we should transition to long break
        if isWorkSession {
            if currentCycle % cyclesBeforeLongBreak == 0 {
                isLongBreak = true
                timeRemaining = longBreakDuration
            } else {
                isLongBreak = false
                timeRemaining = shortBreakDuration
            }
        } else {
            isLongBreak = false
            timeRemaining = workDuration
        }
        print("Cycles elapsed: \(currentCycle)")
        isWorkSession.toggle() // Switch between work and break
    }

    func skipCurrentCycle() {
        startNextCycle()
    }

    func decrementTime() {
        if timeRemaining > 0 {
            timeRemaining -= 1
            setRemainingCyclePercentage()
        } else {
            if timeRemaining == 0 { playSound() }
            startNextCycle()

            if !startCyclesAutomatically {
                stopTimer()
                isRunning = false
            }
        }
    }

    // Function to get current cycle type
    func getCurrentCycleType() -> String {
        if isWorkSession {
            return "Work"
        } else {
            return isLongBreak ? "Long Break" : "Short Break"
        }
    }

    func setRemainingCyclePercentage() {
        if currentPhase == .work {
            remainingCyclePercentage = CGFloat(Float(timeRemaining) / Float(getCurrentCycleTime()))
            return
        }

        remainingCyclePercentage = 1 - CGFloat(Float(timeRemaining) / Float(getCurrentCycleTime()))
    }

    func getCurrentCycleTime() -> Int {
        return currentPhase == .work ? workDuration : (currentPhase == .longBreak ? longBreakDuration : shortBreakDuration)
    }

    func resetCurrentCycle() {
        stopTimer()
        if currentPhase == .work {
            timeRemaining = workDuration
        } else if currentPhase == .shortBreak {
            timeRemaining = shortBreakDuration
        } else if currentPhase == .longBreak {
            timeRemaining = longBreakDuration
        }
    }

    func nextPhase() {
        if currentPhase == .work {
            currentPhase = (currentCycle % cyclesBeforeLongBreak == 0) ? .longBreak : .shortBreak
        } else {
            currentPhase = .work
        }
    }

    func updateTimes() {
        workDuration = UserPreferences.shared.getWorkDuration() * 60
        shortBreakDuration = UserPreferences.shared.getShortBreakDuration() * 60
        longBreakDuration = UserPreferences.shared.getLongBreakDuration() * 60
        timeRemaining = workDuration
        resetCurrentCycle()
    }

    func startTimer() {
        if timeRemaining == 0 {
            startNextCycle()
        }
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.decrementTime()
        }
    }

    func stopTimer() {
        isRunning = false
        timer?.invalidate()
        timer = nil
    }

    func playSound() {
        guard let soundURL = Bundle.main.url(forResource: "chime", withExtension: "wav") else {
            return
        }

        do {
            player = try AVAudioPlayer(contentsOf: soundURL)
        } catch {
            print("Failed to load the sound: \(error)")
        }
        player?.play()
    }
}

// Enum to manage the different phases of a Pomodoro cycle
enum CyclePhase {
    case work
    case shortBreak
    case longBreak
}

extension CyclePhase {
    var title: String {
        switch self {
        case .work:
            return "It’s Work O’Clock"
        case .shortBreak:
            return "Quick Power-Up!"
        case .longBreak:
            return "Reset and RESPARK!"
        }
    }

    var subtitle: String {
        switch self {
        case .work:
            return "Let’s Get Things Done!"
        case .shortBreak:
            return "Just a tiny pause to keep you in the zone."
        case .longBreak:
            return "Step away, clear your mind, and come back stronger."
        }
    }
}
