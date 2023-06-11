//
//  SceneWidgetsLiveActivity.swift
//  SceneWidgets
//
//  Created by Leo Dion on 6/9/23.
//

import ActivityKit
import WidgetKit
import SwiftUI


struct PieWidgetAttributes : ActivityAttributes {
  typealias ContentState = ScenePieSet
  
  let title : String
}


//struct SceneWidgetsAttributes: ActivityAttributes {
//    public struct ContentState: Codable, Hashable {
//        // Dynamic stateful properties about your activity go here!
//        var emoji: String
//      var value : Double
//    }
//
//    // Fixed non-changing properties about your activity go here!
//    var name: String
//}

struct SceneWidgetsLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: PieWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.title)")
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
                  HStack{
                    PieSetView(set: context.state).frame(width: 80.0,alignment:.center)
                    Spacer()
                  }
                  
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.title)")
            } minimal: {
              Text(context.state.title)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension PieWidgetAttributes {
    fileprivate static var preview: PieWidgetAttributes {
      PieWidgetAttributes(title: "Haberdash")
    }
}

extension PieWidgetAttributes.ContentState {
    fileprivate static var smiley: PieWidgetAttributes.ContentState {
      PieWidgetAttributes.ContentState.random(0)
     }
     
     fileprivate static var starEyes: PieWidgetAttributes.ContentState {
       PieWidgetAttributes.ContentState.random(0)
     }
}

#Preview("Dynamic Island", as: .dynamicIsland(.expanded), using: PieWidgetAttributes.preview) {
   SceneWidgetsLiveActivity()
} contentStates: {
  PieWidgetAttributes.ContentState.smiley
  PieWidgetAttributes.ContentState.starEyes
}


#Preview("Notification", as: .content, using: PieWidgetAttributes.preview) {
   SceneWidgetsLiveActivity()
} contentStates: {
  PieWidgetAttributes.ContentState.smiley
  PieWidgetAttributes.ContentState.starEyes
}


