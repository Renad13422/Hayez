//
//  LiveActivity.swift
//  LiveActivity
//
//  Created by ريناد محمد حملي on 24/08/1447 AH.
//
//
// LiveActivity.swift
// LiveActivity
//

import ActivityKit
import WidgetKit
import SwiftUI

// هذا الكود الأساسي لشكل التنبيه
struct LiveActivityLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: HayezActivityAttributes.self) { context in
            // شكل قفل الشاشة
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text("حيز - وقت التركيز").font(.headline).foregroundColor(.orange)
                }
                Spacer()
                Text(context.state.endTime, style: .timer)
                    .font(.system(size: 32, weight: .bold, design: .monospaced))
            }
            .padding()
            
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) { Text("⏳") }
                DynamicIslandExpandedRegion(.trailing) {
                    Text(context.state.endTime, style: .timer).monospacedDigit()
                }
                DynamicIslandExpandedRegion(.center) {
                    Text("\(context.attributes.characterName) يذاكر معك")
                }
            } compactLeading: {
                Text("⏳")
            } compactTrailing: {
                Text(context.state.endTime, style: .timer).monospacedDigit()
            } minimal: {
                Text("⏳")
            }
        }
    }
}
#Preview("Notification", as: .dynamicIsland(.expanded), using: HayezActivityAttributes(characterName: "renad")) {
    LiveActivityLiveActivity()
} contentStates: {
    HayezActivityAttributes.ContentState(endTime: Date().addingTimeInterval(1500))
}
