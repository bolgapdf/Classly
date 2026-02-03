//
//  AddClassView.swift
//  Classly
//
//  Created by Jacob Silva on 2/1/26.
//

import SwiftUI

struct AddClassView: View {
    @Environment(\.dismiss) var dismiss
    
    var classToEdit: ClassSchedule?
    var onSave: (ClassSchedule) -> Void
    
    @State private var emoji = "📚"
    @State private var className = ""
    @State private var roomNumber = ""
    @State private var startTime = Date()
    @State private var endTime = Date()
    @State private var selectedDays: Set<Int> = []
    
    let weekdays = [
        (1, "Sun"),
        (2, "Mon"),
        (3, "Tue"),
        (4, "Wed"),
        (5, "Thu"),
        (6, "Fri"),
        (7, "Sat")
    ]
    
    let emojiOptions = ["📚", "🧬", "➗", "📖", "🧪", "🎨", "🎵", "⚽️", "💻", "🌍", "📐", "✏️", "🔬", "🎭", "📱", "🏃", "🎤", "📝"]
    
    var body: some View {
        NavigationView {
            Form {
                Section("class info") {
                    VStack(alignment: .leading) {
                        Text("emoji")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(emojiOptions, id: \.self) { emojiOption in
                                    Button {
                                        emoji = emojiOption
                                    } label: {
                                        Text(emojiOption)
                                            .font(.title)
                                            .padding(8)
                                            .background(emoji == emojiOption ? Color.blue.opacity(0.2) : Color.clear)
                                            .clipShape(RoundedRectangle(cornerRadius: 8))
                                    }
                                }
                            }
                        }
                    }
                    
                    TextField("Class Name", text: $className)
                    TextField("Room Number", text: $roomNumber)
                }
                
                Section("time") {
                    DatePicker("Start Time", selection: $startTime, displayedComponents: .hourAndMinute)
                    DatePicker("End Time", selection: $endTime, displayedComponents: .hourAndMinute)
                }
                
                Section("days") {
                    ForEach(weekdays, id: \.0) { day in
                        Button {
                            if selectedDays.contains(day.0) {
                                selectedDays.remove(day.0)
                            } else {
                                selectedDays.insert(day.0)
                            }
                        } label: {
                            HStack {
                                Text(day.1)
                                    .foregroundColor(.primary)
                                Spacer()
                                if selectedDays.contains(day.0) {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.blue)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle(classToEdit == nil ? "Add Class" : "Edit Class")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveClass()
                    }
                    .disabled(className.isEmpty || selectedDays.isEmpty)
                }
            }
        }
        .onAppear {
            if let classToEdit = classToEdit {
                emoji = classToEdit.emoji
                className = classToEdit.name
                roomNumber = classToEdit.roomNumber
                startTime = classToEdit.startTime
                endTime = classToEdit.endTime
                selectedDays = Set(classToEdit.weekdays)
            }
        }
    }
    
    private func saveClass() {
        let newClass = ClassSchedule(
            id: classToEdit?.id ?? UUID(),
            emoji: emoji,
            name: className,
            roomNumber: roomNumber,
            startTime: startTime,
            endTime: endTime,
            weekdays: Array(selectedDays).sorted()
        )
        onSave(newClass)
        dismiss()
    }
}

#Preview {
    AddClassView { _ in }
}
