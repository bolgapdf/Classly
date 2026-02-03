//
//  AppIntent.swift
//  ClasslyWidget
//
//  Created by Jacob Silva on 2/1/26.
//

import WidgetKit
import AppIntents

struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource { "Configuration" }
    static var description: IntentDescription { "Widget configuration" }
}
