//
//  PieSetView.swift
//  ObjectiveScene
//
//  Created by Leo Dion on 6/9/23.
//

import SwiftUI

struct PieSetView: View {
  let set : ScenePieSet
  
  var content: some View {
    ZStack{
      ForEach(0..<3) { index in
        
        if index < set.pies.count {
          let pie = set.pies[index]
          PieView(pie: pie, index: index).padding(8.0)          
        }
      }
    }
  }
  //.frame(width: width / 3, height: width / 3, alignment: .center)
    var body: some View {
      content
    }
}

#Preview {
  PieSetView(set: .random(0))
}
#Preview {
  PieSetView(set: .random(0)).frame(width: 100)
}
