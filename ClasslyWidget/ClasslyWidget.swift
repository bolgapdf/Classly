//
//  ClasslyWidget.swift
//  ClasslyWidget
//
//  Created by Jacob Silva on 2/1/26.
//

import WidgetKit
import SwiftUI

// MARK: - Data Models

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
    
    /// check if class occurs on date
    func occursOn(date: Date) -> Bool {
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: date)
        return weekdays.contains(weekday)
    }
    
    /// get date-time for class on specific date
    func dateTime(on date: Date) -> Date? {
        let calendar = Calendar.current
        let startComponents = calendar.dateComponents([.hour, .minute], from: startTime)
        return calendar.date(bySettingHour: startComponents.hour ?? 0,
                            minute: startComponents.minute ?? 0,
                            second: 0,
                            of: date)
    }
}

// helper to get classes for today
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

struct Provider: AppIntentTimelineProvider {
    
    // TODO: replace with actual data loading from userdefaults or app group
    func loadSchedule() -> [ClassSchedule] {
        // sample data for testing
        let calendar = Calendar.current
        let now = Date()
        
        return [
            ClassSchedule(
                emoji: "🧬",
                name: "Biology 101",
                roomNumber: "Room 204",
                startTime: calendar.date(bySettingHour: 9, minute: 0, second: 0, of: now)!,
                endTime: calendar.date(bySettingHour: 10, minute: 30, second: 0, of: now)!,
                weekdays: [2, 4, 6] // mon, wed, fri
            ),
            ClassSchedule(
                emoji: "➗",
                name: "Mathematics",
                roomNumber: "Room 305",
                startTime: calendar.date(bySettingHour: 11, minute: 0, second: 0, of: now)!,
                endTime: calendar.date(bySettingHour: 12, minute: 30, second: 0, of: now)!,
                weekdays: [2, 4, 6]
            ),
            ClassSchedule(
                emoji: "📖",
                name: "English Lit",
                roomNumber: "Room 101",
                startTime: calendar.date(bySettingHour: 14, minute: 0, second: 0, of: now)!,
                endTime: calendar.date(bySettingHour: 15, minute: 30, second: 0, of: now)!,
                weekdays: [2, 4, 6]
            )
        ]
    }
    
    func createEntry(date: Date, configuration: ConfigurationAppIntent) -> SimpleEntry {
        let allClasses = loadSchedule()
        let todayClasses = ClassSchedule.getClassesForToday(from: allClasses)
        let nextClass = ClassSchedule.getNextClass(from: todayClasses)
        let remainingCount = nextClass != nil ? ClassSchedule.getRemainingClassCount(from: todayClasses, after: nextClass!) : 0
        
        return SimpleEntry(
            date: date,
            configuration: configuration,
            nextClass: nextClass,
            remainingClassCount: remainingCount
        )
    }
    
    func placeholder(in context: Context) -> SimpleEntry {
        createEntry(date: Date(), configuration: ConfigurationAppIntent())
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        createEntry(date: Date(), configuration: configuration)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []

        let currentDate = Date()
        let calendar = Calendar.current
        
        // hourly updates throughout the day
        for hourOffset in 0 ..< 24 {
            let entryDate = calendar.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = createEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }

//    func relevances() async -> WidgetRelevances<ConfigurationAppIntent> {
//        // widget relevances context
//    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
    let nextClass: ClassSchedule?
    let remainingClassCount: Int
}

struct ClasslyWidgetEntryView : View {
    
    var entry: Provider.Entry

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // date
            Text(entry.date.formatted(.dateTime.weekday(.wide).month(.defaultDigits).day()))
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundStyle(.secondary)
            
            if let nextClass = entry.nextClass {
                VStack(alignment: .leading, spacing: 2) {
                    // emoji + class name + time
                    HStack(alignment: .top, spacing: 1) {
                        Text(nextClass.emoji)
                            .font(.body)
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text(nextClass.name)
                                .font(.body)
                                .fontWeight(.semibold)
                                .lineLimit(1)
                                .minimumScaleFactor(0.8)
                            
                            Text("\(nextClass.startTime.formatted(date: .omitted, time: .shortened))-\(nextClass.endTime.formatted(date: .omitted, time: .shortened))")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        
                        Spacer(minLength: 0)
                    }
                    
                    // room number
                    HStack(spacing: 5) {
                        Image(systemName: "location.fill")
                            .font(.caption)
                        Text(nextClass.roomNumber)
                            .font(.caption)
                        
                        Spacer()
                    }
                    .foregroundStyle(.secondary)
                    
                    .padding(10)
                    
                    // remaining classes
                    if entry.remainingClassCount > 0 {
                        Text("+ \(entry.remainingClassCount) classes left today!")
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundStyle(.tertiary)
                    }
                }
            } else {
                // no classes
                Spacer()
                VStack(spacing: 8) {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.title)
                        .foregroundStyle(.green)
                    Text("No more classes!")
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity)
                Spacer()
            }
            
            Spacer(minLength: 0)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}

struct ClasslyWidget: Widget {
    let kind: String = "ClasslyWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            ClasslyWidgetEntryView(entry: entry)
                .containerBackground(for: .widget) {
                    Color.gray.opacity(0.4)
                }
        }
    }
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

#Preview(as: .systemSmall) {
    ClasslyWidget()
} timeline: {
    // with next class
    SimpleEntry(
        date: .now,
        configuration: .smiley,
        nextClass: ClassSchedule(
            emoji: "🧬",
            name: "Biology 101",
            roomNumber: "Room 204",
            startTime: Calendar.current.date(bySettingHour: 2, minute: 30, second: 0, of: .now)!,
            endTime: Calendar.current.date(bySettingHour: 4, minute: 0, second: 0, of: .now)!,
            weekdays: [1, 2, 3, 4, 5, 6, 7]
        ),
        remainingClassCount: 2
    )
    
    // no more classes
    SimpleEntry(
        date: .now,
        configuration: .starEyes,
        nextClass: nil,
        remainingClassCount: 0
    )
}
