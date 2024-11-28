//
//  UserPreferences.swift
//  Respark
//
//  Created by Mateusz Ficek on 27/11/2024.
//

import Foundation

class UserPreferences {
    static let shared = UserPreferences()
    private init() {}

    private let workDurationKey = "workDuration"
    private let shortBreakDurationKey = "shortBreakDuration"
    private let longBreakDurationKey = "longBreakDuration"
    private let startStagesAutomaticallyKey = "startStagesAutomatically"
    private let longBreakIntervalKey = "longBreakInterval"
    private let finishedOnboardingKey = "finishedOnboarding"

    private let defaultWorkDuration = 25
    private let defaultShortBreakDuration = 5
    private let defaultLongBreakDuration = 15
    private let defualtStartStagesAutomatically = false
    private let defaultLongBreakInterval = 4.0
    private let defaultFinishedOnboarding = false
    
    func saveTimeSettings(workDuration: Int, shortBreakDuration: Int, longBreakDuration: Int) {
        UserDefaults.standard.set(workDuration, forKey: workDurationKey)
        UserDefaults.standard.set(shortBreakDuration, forKey: shortBreakDurationKey)
        UserDefaults.standard.set(longBreakDuration, forKey: longBreakDurationKey)
    }
    
    func saveAutomationSettings(startStagesAutomatically: Bool) {
        UserDefaults.standard.set(startStagesAutomatically, forKey: startStagesAutomaticallyKey)
    }
    
    func saveLongBreakInterval(longBreakInterval: Double) {
        UserDefaults.standard.set(longBreakInterval, forKey: longBreakIntervalKey)
    }
    
    func getWorkDuration() -> Int {
        return UserDefaults.standard.integer(forKey: workDurationKey) == 0 ? defaultWorkDuration : UserDefaults.standard.integer(forKey: workDurationKey)
    }
    
    func getShortBreakDuration() -> Int {
        return UserDefaults.standard.integer(forKey: shortBreakDurationKey) == 0 ? defaultShortBreakDuration : UserDefaults.standard.integer(forKey: shortBreakDurationKey)
    }
    
    func getLongBreakDuration() -> Int {
        return UserDefaults.standard.integer(forKey: longBreakDurationKey) == 0 ? defaultLongBreakDuration : UserDefaults.standard.integer(forKey: longBreakDurationKey)
    }
    
    func getStartStagesAutomatically() -> Bool {
        return UserDefaults.standard.bool(forKey: startStagesAutomaticallyKey)
    }
    
    func getLongBreakInterval() -> Double {
        return UserDefaults.standard.double(forKey: longBreakIntervalKey) == 0.0 ? defaultLongBreakInterval : UserDefaults.standard.double(forKey: longBreakIntervalKey)
    }
    
    func markOnboardingFinished() {
        UserDefaults.standard.set(true, forKey: finishedOnboardingKey)
    }
    
    func getFinishedOnboarding() -> Bool {
        return UserDefaults.standard.bool(forKey: finishedOnboardingKey)
    }
}
