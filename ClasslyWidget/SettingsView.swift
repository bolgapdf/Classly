//
//  SettingsView.swift
//  Classly
//
//  Created by Jacob Silva on 2/1/26.
//

import SwiftUI

struct SettingsView: View {
    @Binding var backgroundColor: String
    @Environment(\.dismiss) var dismiss
    
    let colorOptions = [
        ("gray", Color.gray),
        ("blue", Color.blue),
        ("purple", Color.purple),
        ("pink", Color.pink),
        ("red", Color.red),
        ("orange", Color.orange),
        ("yellow", Color.yellow),
        ("green", Color.green),
        ("teal", Color.teal),
        ("indigo", Color.indigo),
        ("black", Color.black)
    ]
    
    var body: some View {
        NavigationView {
            Form {
                Section("widget background") {
                    ForEach(colorOptions, id: \.0) { option in
                        Button {
                            backgroundColor = option.0
                            ScheduleManager.shared.saveBackgroundColor(option.0)
                        } label: {
                            HStack {
                                Circle()
                                    .fill(option.1.opacity(0.4))
                                    .frame(width: 30, height: 30)
                                Text(option.0.capitalized)
                                    .foregroundColor(.primary)
                                Spacer()
                                if backgroundColor == option.0 {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.blue)
                                }
                            }
                        }
                    }
                }
                
                Section("about") {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("1.0")
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    SettingsView(backgroundColor: .constant("gray"))
}
