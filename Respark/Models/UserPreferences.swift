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

    static let workDurationKey = "workDuration"
    static let shortBreakDurationKey = "shortBreakDuration"
    static let longBreakDurationKey = "longBreakDuration"
    static let startStagesAutomaticallyKey = "startStagesAutomatically"
    static let longBreakIntervalKey = "longBreakInterval"
    private let finishedOnboardingKey = "finishedOnboarding"

    private let defaultWorkDuration = 2
    private let defaultShortBreakDuration = 1
    private let defaultLongBreakDuration = 1
    private let defualtStartStagesAutomatically = false
    private let defaultLongBreakInterval = 4.0
    private let defaultFinishedOnboarding = false
    
    func saveTimeSettings(workDuration: Int, shortBreakDuration: Int, longBreakDuration: Int) {
        UserDefaults.standard.set(workDuration, forKey: UserPreferences.workDurationKey)
        UserDefaults.standard.set(shortBreakDuration, forKey: UserPreferences.shortBreakDurationKey)
        UserDefaults.standard.set(longBreakDuration, forKey: UserPreferences.longBreakDurationKey)
    }
    
    func saveAutomationSettings(startStagesAutomatically: Bool) {
        UserDefaults.standard.set(startStagesAutomatically, forKey: UserPreferences.startStagesAutomaticallyKey)
    }
    
    func saveLongBreakInterval(longBreakInterval: Double) {
        UserDefaults.standard.set(longBreakInterval, forKey: UserPreferences.longBreakIntervalKey)
    }
    
    func getWorkDuration() -> Int {
        return UserDefaults.standard.integer(forKey: UserPreferences.workDurationKey) == 0 ? defaultWorkDuration : UserDefaults.standard.integer(forKey: UserPreferences.workDurationKey)
    }
    
    func getShortBreakDuration() -> Int {
        return UserDefaults.standard.integer(forKey: UserPreferences.shortBreakDurationKey) == 0 ? defaultShortBreakDuration : UserDefaults.standard.integer(forKey: UserPreferences.shortBreakDurationKey)
    }
    
    func getLongBreakDuration() -> Int {
        return UserDefaults.standard.integer(forKey: UserPreferences.longBreakDurationKey) == 0 ? defaultLongBreakDuration : UserDefaults.standard.integer(forKey: UserPreferences.longBreakDurationKey)
    }
    
    func getStartStagesAutomatically() -> Bool {
        return UserDefaults.standard.bool(forKey: UserPreferences.startStagesAutomaticallyKey)
    }
    
    func getLongBreakInterval() -> Double {
        return UserDefaults.standard.double(forKey: UserPreferences.longBreakIntervalKey) == 0.0 ? defaultLongBreakInterval : UserDefaults.standard.double(forKey: UserPreferences.longBreakIntervalKey)
    }
    
    func markOnboardingFinished() {
        UserDefaults.standard.set(true, forKey: finishedOnboardingKey)
    }
    
    func getFinishedOnboarding() -> Bool {
        return UserDefaults.standard.bool(forKey: finishedOnboardingKey)
    }
}
