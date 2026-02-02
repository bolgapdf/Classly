//
//  ClasslyWidgetBundle.swift
//  ClasslyWidget
//
//  Created by Jacob Silva on 2/1/26.
//

import WidgetKit
import SwiftUI

@main
struct ClasslyWidgetBundle: WidgetBundle {
    var body: some Widget {
        ClasslyWidget()
        ClasslyWidgetControl()
        ClasslyWidgetLiveActivity()
    }
}
