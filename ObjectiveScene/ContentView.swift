//
//  ContentView.swift
//  ObjectiveScene
//
//  Created by Leo Dion on 6/9/23.
//

import SwiftUI
import SwiftData
import Charts

struct ScenePieSet : Identifiable {
  let pies : [ScenePie]
  let id = UUID()
  let title : String
  
  static func random (_ index : Int) -> ScenePieSet {
    ScenePieSet(pies:
                  (0...2).map({ index in
        .init(value: .random(in: 0...1))
    }), title: setNames.randomElement()!
    )
  }
}
struct ScenePie : Identifiable {
  let id = UUID()
  let value : Double
  
}

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
  private let sets : [ScenePieSet] = (0...20).map(ScenePieSet.random)
  let radii : [(MarkDimension, MarkDimension)] = [
    (33.0, 45.0),
    (21.0, 32.0),
    (10.0, 20.0),
  ]
  
  let colors : [Color] = [
    .red,
    .green,
    .purple
  ]
  
    var body: some View {
        NavigationStack {
          ScrollView{
            VStack{
              GeometryReader(content: { geometry in
                LazyVGrid(columns: [
                  GridItem(.adaptive(
                    minimum: geometry.size.width / 4,
                    maximum: geometry.size.width / 2
                  )
                  )
                ], content: {
                  ForEach(sets) { set in
                    VStack{
                      ZStack{
                        ForEach(0..<3) { index in
                          
                          if index < set.pies.count {
                            let pie = set.pies[index]
                            GeometryReader { proxy in
                              
                              Chart {
                                SectorMark(
                                  angle:
                                      .value("stuff", 1 - pie.value)
                                  
                                ).opacity(0.0)
                                
                                SectorMark(angle:
                                    .value(pie.id.uuidString, pie.value),
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
                            }.padding(8.0).frame(width: geometry.size.width / 3, height: geometry.size.width / 3, alignment: .center)
                            
                          }
                        }
                      }
                      
                      Text(set.title).fontWeight(.light)
                    }
                  }
                })
              })
            }
          }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
