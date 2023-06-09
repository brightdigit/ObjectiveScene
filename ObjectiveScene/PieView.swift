//
//  PieView.swift
//  ObjectiveScene
//
//  Created by Leo Dion on 6/9/23.
//

import SwiftUI
import Charts

struct PieView: View {
  @State var value = 0.0
  let colors : [Color] = [
    .red,
    .green,
    .purple
  ]
  let pie : ScenePie
  let index : Int
  func chart(_ proxy: GeometryProxy) -> some View {
    Chart {
      SectorMark(
        angle:
            .value("stuff", 1 - self.value)
        
      ).opacity(0.0)
      
      SectorMark(angle:
          .value(pie.id.uuidString, -self.value),
                 innerRadius: MarkDimension(
                  floatLiteral:
                    (proxy.size.width / 2.0) / (3.0) * (3 - Double(index) - 1.0) + 5.0
                 ),
                 outerRadius: MarkDimension(
                  floatLiteral:
                    (proxy.size.width / 2.0) / (3.0) * (3 - Double(index))
                 )
      ).foregroundStyle(colors[index])
    }
  }
  
    var body: some View {
      GeometryReader { proxy in
        
        self.chart(proxy)
       
      }.onAppear(perform: {
        withAnimation {
          self.value = pie.value
        }
      })
      
    
    }
}

#Preview {
  PieView(pie: .init(value: 0.5),  index: 1)
}
