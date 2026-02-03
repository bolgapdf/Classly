//
//  ClassSchedule.swift
//  Classly
//
//  Created by Jacob Silva on 2/1/26.
//

import Foundation

struct ClassSchedule: Codable, Identifiable {
    let id: UUID
    let emoji: String
    let name: String
    let roomNumber: String
    let startTime: Date
    let endTime: Date
    let weekdays: [Int]
    
    init(id: UUID = UUID(), emoji: String = "📚", name: String, roomNumber: String, startTime: Date, endTime: Date, weekdays: [Int]) {
        self.id = id
        self.emoji = emoji
        self.name = name
        self.roomNumber = roomNumber
        self.startTime = startTime
        self.endTime = endTime
        self.weekdays = weekdays
    }
    
    func occursOn(date: Date) -> Bool {
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: date)
        return weekdays.contains(weekday)
    }
    
    func dateTime(on date: Date) -> Date? {
        let calendar = Calendar.current
        let startComponents = calendar.dateComponents([.hour, .minute], from: startTime)
        return calendar.date(bySettingHour: startComponents.hour ?? 0,
                            minute: startComponents.minute ?? 0,
                            second: 0,
                            of: date)
    }
}

extension ClassSchedule {
    static func getClassesForToday(from allClasses: [ClassSchedule]) -> [ClassSchedule] {
        let today = Date()
        let calendar = Calendar.current
        
        return allClasses
            .filter { $0.occursOn(date: today) }
            .sorted { class1, class2 in
                guard let date1 = class1.dateTime(on: today),
                      let date2 = class2.dateTime(on: today) else {
                    return false
                }
                return date1 < date2
            }
    }
    
    static func getNextClass(from todayClasses: [ClassSchedule]) -> ClassSchedule? {
        let now = Date()
        let calendar = Calendar.current
        let today = Date()
        
        return todayClasses.first { classItem in
            guard let classDateTime = classItem.dateTime(on: today) else { return false }
            return classDateTime > now
        }
    }
    
    static func getRemainingClassCount(from todayClasses: [ClassSchedule], after nextClass: ClassSchedule) -> Int {
        guard let nextClassIndex = todayClasses.firstIndex(where: { $0.id == nextClass.id }) else {
            return 0
        }
        return max(0, todayClasses.count - nextClassIndex - 1)
    }
}

