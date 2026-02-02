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
    let weekdays: [Int] // 1=sun, 2=mon, etc.
    
    init(id: UUID = UUID(), emoji: String = "📚", name: String, roomNumber: String, startTime: Date, endTime: Date, weekdays: [Int]) {
        self.id = id
        self.emoji = emoji
        self.name = name
        self.roomNumber = roomNumber
        self.startTime = startTime
        self.endTime = endTime
        self.weekdays = weekdays
    }
}
