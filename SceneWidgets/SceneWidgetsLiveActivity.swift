//
//  SceneWidgetsLiveActivity.swift
//  SceneWidgets
//
//  Created by Leo Dion on 6/9/23.
//

import ActivityKit
import WidgetKit
import SwiftUI


//struct PieWidgetAttributes : ActivityAttributes {
//  typealias ContentState = ScenePieSet
//  
//  let title : String
//}


struct SceneWidgetsAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
      var value : Double
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct SceneWidgetsLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: SceneWidgetsAttributes.self) { context in
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

extension SceneWidgetsAttributes {
    fileprivate static var preview: SceneWidgetsAttributes {
        SceneWidgetsAttributes(name: "World")
    }
}

extension SceneWidgetsAttributes.ContentState {
    fileprivate static var smiley: SceneWidgetsAttributes.ContentState {
      SceneWidgetsAttributes.ContentState(emoji: "😀", value: 0.5)
     }
     
     fileprivate static var starEyes: SceneWidgetsAttributes.ContentState {
         SceneWidgetsAttributes.ContentState(emoji: "🤩", value: 0.5)
     }
}

#Preview("Dynamic Island", as: .dynamicIsland(.expanded), using: SceneWidgetsAttributes.preview) {
   SceneWidgetsLiveActivity()
} contentStates: {
    SceneWidgetsAttributes.ContentState.smiley
    SceneWidgetsAttributes.ContentState.starEyes
}


#Preview("Notification", as: .content, using: SceneWidgetsAttributes.preview) {
   SceneWidgetsLiveActivity()
} contentStates: {
    SceneWidgetsAttributes.ContentState.smiley
    SceneWidgetsAttributes.ContentState.starEyes
}


