//
//  ClasslyWidget.swift
//  ClasslyWidget
//
//  Created by Jacob Silva on 2/1/26.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    
    func loadSchedule() -> [ClassSchedule] {
        return ScheduleManager.shared.loadSchedules()
    }
    
    func loadBackgroundColor() -> String {
        return ScheduleManager.shared.loadBackgroundColor()
    }
    
    func createEntry(date: Date, configuration: ConfigurationAppIntent) -> SimpleEntry {
        let allClasses = loadSchedule()
        let todayClasses = ClassSchedule.getClassesForToday(from: allClasses)
        let nextClass = ClassSchedule.getNextClass(from: todayClasses)
        let remainingCount = nextClass != nil ? ClassSchedule.getRemainingClassCount(from: todayClasses, after: nextClass!) : 0
        let bgColor = loadBackgroundColor()
        
        return SimpleEntry(
            date: date,
            configuration: configuration,
            nextClass: nextClass,
            remainingClassCount: remainingCount,
            backgroundColor: bgColor
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
        
        for hourOffset in 0 ..< 24 {
            let entryDate = calendar.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = createEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
    let nextClass: ClassSchedule?
    let remainingClassCount: Int
    let backgroundColor: String
}

struct ClasslyWidgetEntryView : View {
    
    var entry: Provider.Entry

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(entry.date.formatted(.dateTime.weekday(.wide).month(.defaultDigits).day()))
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundStyle(.secondary)
            
            if let nextClass = entry.nextClass {
                VStack(alignment: .leading, spacing: 2) {
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
                    
                    HStack(spacing: 5) {
                        Image(systemName: "location.fill")
                            .font(.caption)
                        Text(nextClass.roomNumber)
                            .font(.caption)
                        
                        Spacer()
                    }
                    .foregroundStyle(.secondary)
                    
                    if entry.remainingClassCount > 0 {
                        Text("+ \(entry.remainingClassCount) classes left today!")
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundStyle(.tertiary)
                    }
                }
            } else {
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
                    Color.fromString(entry.backgroundColor).opacity(0.4)
                }
        }
    }
}

extension ConfigurationAppIntent {
    fileprivate static var preview: ConfigurationAppIntent {
        ConfigurationAppIntent()
    }
}

#Preview(as: .systemSmall) {
    ClasslyWidget()
} timeline: {
    SimpleEntry(
        date: .now,
        configuration: .preview,
        nextClass: ClassSchedule(
            emoji: "🧬",
            name: "Biology 101",
            roomNumber: "Room 204",
            startTime: Calendar.current.date(bySettingHour: 2, minute: 30, second: 0, of: .now)!,
            endTime: Calendar.current.date(bySettingHour: 4, minute: 0, second: 0, of: .now)!,
            weekdays: [1, 2, 3, 4, 5, 6, 7]
        ),
        remainingClassCount: 2,
        backgroundColor: "blue"
    )
    
    SimpleEntry(
        date: .now,
        configuration: .preview,
        nextClass: nil,
        remainingClassCount: 0,
        backgroundColor: "purple"
    )
}
