//
//  CycleManager.swift
//  Respark
//
//  Created by Mateusz Ficek on 29/11/2024.
//

import Foundation

class CycleManager: ObservableObject {
    @Published var currentPhase: CyclePhase = .work // Work or break phase

    @Published var workDuration: Int // in seconds
    @Published var shortBreakDuration: Int // in seconds
    @Published var longBreakDuration: Int // in seconds
    @Published var cyclesBeforeLongBreak: Int

    @Published var currentCycle: Int = 0
    @Published var isWorkSession: Bool = true
    @Published var timeRemaining: Int
    @Published var isLongBreak: Bool = false

    init(workDuration: Int, shortBreakDuration: Int, longBreakDuration: Int, cyclesBeforeLongBreak: Int) {
        self.workDuration = workDuration
        self.shortBreakDuration = shortBreakDuration
        self.longBreakDuration = longBreakDuration
        self.cyclesBeforeLongBreak = cyclesBeforeLongBreak
        self.timeRemaining = workDuration
    }

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
        } else {
            startNextCycle()
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

    func getRemainingCyclePercentage() -> CGFloat {
        if currentPhase == .work {
            return CGFloat(Float(timeRemaining) / Float(getCurrentCycleTime()))
        }

        return 1 - CGFloat(Float(timeRemaining) / Float(getCurrentCycleTime()))
    }

    func getCurrentCycleTime() -> Int {
        return currentPhase == .work ? workDuration : (currentPhase == .longBreak ? longBreakDuration : shortBreakDuration)
    }

    func resetCurrentCycle() {
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
