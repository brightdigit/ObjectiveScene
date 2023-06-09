//
//  PiezView.swift
//  ObjectiveScene
//
//  Created by Leo Dion on 6/9/23.
//

import SwiftUI
import Charts

struct PiezView: View {
    var body: some View {
      ZStack{
        
        Chart{
          SectorMark(angle: .value("", 5), innerRadius: 50.0, outerRadius: 100.0)
          SectorMark(angle: .value("", 10)).opacity(0.0)
        }
        
          Chart{
            SectorMark(angle: .value("", 5), innerRadius: 75.0, outerRadius: 150.0)
            SectorMark(angle: .value("", 10)).opacity(0.0)
          }.foregroundStyle(Color.green)
        
          Chart{
            SectorMark(angle: .value("", 5), innerRadius: 100.0, outerRadius: 200.0)
            SectorMark(angle: .value("", 10)).opacity(0.0)
          }.foregroundStyle(Color.red)
      }
    }
}

#Preview {
    PiezView()
}
