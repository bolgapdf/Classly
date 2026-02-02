//
//  ClasslyWidgetLiveActivity.swift
//  ClasslyWidget
//
//  Created by Jacob Silva on 2/1/26.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct ClasslyWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct ClasslyWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: ClasslyWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension ClasslyWidgetAttributes {
    fileprivate static var preview: ClasslyWidgetAttributes {
        ClasslyWidgetAttributes(name: "World")
    }
}

extension ClasslyWidgetAttributes.ContentState {
    fileprivate static var smiley: ClasslyWidgetAttributes.ContentState {
        ClasslyWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: ClasslyWidgetAttributes.ContentState {
         ClasslyWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: ClasslyWidgetAttributes.preview) {
   ClasslyWidgetLiveActivity()
} contentStates: {
    ClasslyWidgetAttributes.ContentState.smiley
    ClasslyWidgetAttributes.ContentState.starEyes
}
