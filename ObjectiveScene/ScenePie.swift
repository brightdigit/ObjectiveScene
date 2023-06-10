//
//  ScenePie.swift
//  ObjectiveScene
//
//  Created by Leo Dion on 6/9/23.
//

import Foundation
struct ScenePieSet : Identifiable, Codable, Hashable {
  internal init(pies: [ScenePie], id: UUID = .init(), title: String) {
    self.pies = pies
    self.id = id
    self.title = title
  }
  
  static func == (lhs: ScenePieSet, rhs: ScenePieSet) -> Bool {
    lhs.id == rhs.id
  }
  
  let pies : [ScenePie]
  let id : UUID
  let title : String
  
  static func random (_ index : Int) -> ScenePieSet {
    ScenePieSet(pies:
                  (0...2).map({ index in
        .init(value: .random(in: 0...1))
    }), title: setNames.randomElement()!
    )
  }
  
  
}
struct ScenePie : Identifiable, Codable, Hashable {
  internal init(id: UUID = .init(), value: Double) {
    self.id = id
    self.value = value
  }
  
  let id : UUID
  let value : Double
  
}
