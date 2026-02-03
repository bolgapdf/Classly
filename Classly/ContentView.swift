//
//  ContentView.swift
//  Classly
//
//  Created by Jacob Silva on 2/1/26.
//

import SwiftUI

struct ContentView: View {
    @State private var schedules: [ClassSchedule] = []
    @State private var showingAddClass = false
    @State private var showingSettings = false
    @State private var editingClass: ClassSchedule?
    @State private var backgroundColor = "gray"
    
    var body: some View {
        NavigationView {
            Group {
                if schedules.isEmpty {
                    VStack(spacing: 20) {
                        Image(systemName: "calendar.badge.plus")
                            .font(.system(size: 60))
                            .foregroundStyle(.secondary)
                        
                        Text("No Classes Yet")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Text("Tap the + button to add your first class")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                } else {
                    List {
                        ForEach(schedules) { schedule in
                            ClassRow(schedule: schedule)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    editingClass = schedule
                                }
                        }
                        .onDelete(perform: deleteClasses)
                    }
                }
            }
            .navigationTitle("My Schedule")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        showingSettings = true
                    } label: {
                        Label("Settings", systemImage: "gear")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddClass = true
                    } label: {
                        Label("Add Class", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddClass) {
                AddClassView { newClass in
                    schedules.append(newClass)
                    saveSchedules()
                }
            }
            .sheet(item: $editingClass) { classToEdit in
                AddClassView(classToEdit: classToEdit) { updatedClass in
                    if let index = schedules.firstIndex(where: { $0.id == updatedClass.id }) {
                        schedules[index] = updatedClass
                        saveSchedules()
                    }
                }
            }
            .sheet(isPresented: $showingSettings) {
                SettingsView(backgroundColor: $backgroundColor)
            }
        }
        .onAppear {
            loadSchedules()
            backgroundColor = ScheduleManager.shared.loadBackgroundColor()
        }
    }
    
    private func loadSchedules() {
        schedules = ScheduleManager.shared.loadSchedules()
    }
    
    private func saveSchedules() {
        ScheduleManager.shared.saveSchedules(schedules)
    }
    
    private func deleteClasses(at offsets: IndexSet) {
        schedules.remove(atOffsets: offsets)
        saveSchedules()
    }
}

struct ClassRow: View {
    let schedule: ClassSchedule
    
    var body: some View {
        HStack(spacing: 12) {
            Text(schedule.emoji)
                .font(.title)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(schedule.name)
                    .font(.headline)
                
                HStack {
                    Text("\(schedule.startTime.formatted(date: .omitted, time: .shortened)) - \(schedule.endTime.formatted(date: .omitted, time: .shortened))")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    
                    Text("•")
                        .foregroundStyle(.secondary)
                    
                    Text(schedule.roomNumber)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                
                Text(weekdaysString(schedule.weekdays))
                    .font(.caption)
                    .foregroundStyle(.tertiary)
            }
        }
        .padding(.vertical, 4)
    }
    
    private func weekdaysString(_ weekdays: [Int]) -> String {
        let dayNames = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
        return weekdays.sorted()
            .compactMap { weekday in
                weekday >= 1 && weekday <= 7 ? dayNames[weekday - 1] : nil
            }
            .joined(separator: ", ")
    }
}

#Preview {
    ContentView()
}
