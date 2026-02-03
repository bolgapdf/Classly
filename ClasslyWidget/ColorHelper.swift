//
//  ColorHelper.swift
//  Classly
//
//  Created by Jacob Silva on 2/1/26.
//

import SwiftUI

extension Color {
    static func fromString(_ colorString: String) -> Color {
        switch colorString.lowercased() {
        case "blue": return .blue
        case "purple": return .purple
        case "pink": return .pink
        case "red": return .red
        case "orange": return .orange
        case "yellow": return .yellow
        case "green": return .green
        case "teal": return .teal
        case "indigo": return .indigo
        case "black": return .black
        default: return .gray
        }
    }
}
