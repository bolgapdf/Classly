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
    
    private let appGroupID = "group.com.jacobsilva.classly"
    
    private let schedulesKey = "savedSchedules"
    private let backgroundColorKey = "backgroundColor"
    
    private var userDefaults: UserDefaults? {
        UserDefaults(suiteName: appGroupID)
    }
    
    func saveSchedules(_ schedules: [ClassSchedule]) {
        guard let userDefaults = userDefaults,
              let encoded = try? JSONEncoder().encode(schedules) else {
            return
        }
        
        userDefaults.set(encoded, forKey: schedulesKey)
        userDefaults.synchronize()
        WidgetCenter.shared.reloadAllTimelines()
    }
    
    func loadSchedules() -> [ClassSchedule] {
        guard let userDefaults = userDefaults,
              let data = userDefaults.data(forKey: schedulesKey),
              let schedules = try? JSONDecoder().decode([ClassSchedule].self, from: data) else {
            return []
        }
        
        return schedules
    }
    
    func saveBackgroundColor(_ color: String) {
        guard let userDefaults = userDefaults else { return }
        userDefaults.set(color, forKey: backgroundColorKey)
        userDefaults.synchronize()
        WidgetCenter.shared.reloadAllTimelines()
    }
    
    func loadBackgroundColor() -> String {
        return userDefaults?.string(forKey: backgroundColorKey) ?? "gray"
    }
}
