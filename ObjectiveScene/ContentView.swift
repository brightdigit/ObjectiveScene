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
  
  static func random (_ index : Int) -> ScenePieSet {
    ScenePieSet(pies:
                  (0...2).map({ index in
        .init(value: Double(index + 1) * 1.0 / 3.0)
    })
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
    (21.0, 30.0),
    (12.0, 20.0),
    (5.0, 10.0),
  ]
  
  let colors : [Color] = [
    .red,
    .green,
    .purple
  ]
  
    var body: some View {
        NavigationView {
          VStack{
            LazyVGrid(columns: [
              GridItem(.adaptive(minimum: 120, maximum: 150))
            ], content: {
              ForEach(sets) { set in
                ZStack{
                  ForEach(0..<3) { index in
                    
                    if index < set.pies.count {
                      let pie = set.pies[index]
                      Chart {
                        SectorMark(
                          angle:
                              .value("stuff", 1 - pie.value)
                          
                        ).opacity(0.0)
                        
                        SectorMark(angle:
                            .value(pie.id.uuidString, pie.value),
                                   innerRadius: radii[index].0,
                                   outerRadius: radii[index].1
                        ).foregroundStyle(colors[index])
                      }
                    }
                  }
                }
              }
            })
            Spacer()
          }
//            List {
//                ForEach(items) { item in
//                    NavigationLink {
//                        Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
//                    } label: {
//                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
//                    }
//                }
//                .onDelete(perform: deleteItems)
//            }
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
            Text("Select an item")
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
