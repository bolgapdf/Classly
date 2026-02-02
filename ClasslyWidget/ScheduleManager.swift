//
//  ScheduleManager.swift
//  Classly
//
//  Created by Jacob Silva on 2/1/26.
//

import Foundation
import WidgetKit

// shared data manager for app and widget
class ScheduleManager {
    static let shared = ScheduleManager()
    
    // app group identifier - you'll need to set this up in your targets
    private let appGroupID = "group.com.yourcompany.classly" // TODO: change this to match your app group
    
    private let schedulesKey = "savedSchedules"
    private let backgroundColorKey = "backgroundColor"
    
    private var userDefaults: UserDefaults? {
        UserDefaults(suiteName: appGroupID)
    }
    
    // save schedule to shared storage
    func saveSchedules(_ schedules: [ClassSchedule]) {
        guard let userDefaults = userDefaults else { return }
        
        if let encoded = try? JSONEncoder().encode(schedules) {
            userDefaults.set(encoded, forKey: schedulesKey)
            
            // reload widget to show new data
            WidgetCenter.shared.reloadAllTimelines()
        }
    }
    
    // load schedule from shared storage
    func loadSchedules() -> [ClassSchedule] {
        guard let userDefaults = userDefaults,
              let data = userDefaults.data(forKey: schedulesKey),
              let schedules = try? JSONDecoder().decode([ClassSchedule].self, from: data) else {
            return []
        }
        return schedules
    }
    
    // save background color
    func saveBackgroundColor(_ color: String) {
        userDefaults?.set(color, forKey: backgroundColorKey)
        WidgetCenter.shared.reloadAllTimelines()
    }
    
    // load background color
    func loadBackgroundColor() -> String {
        return userDefaults?.string(forKey: backgroundColorKey) ?? "gray"
    }
}
