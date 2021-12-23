//
//  OptionalState.swift
//  SampleAppOfTCA
//
//  Created by Yosuke NAKAYAMA on 2021/12/21.
//

import Foundation

import Foundation
import SwiftUI
import ComposableArchitecture

// State
struct OptionalState: Equatable {
    var counter: CounterState?
}

// Action

enum OptionalAction {
    case optionalCounter(CounterAction)
    case toggleOptionalCounter
}

// Environment

struct OptionalEnv {}

// Reducer
// public struct Reducer<State, Action, Environment>

let optionalStateReducer = Reducer<OptionalState, OptionalAction, OptionalEnv> { state, action, env in
    
    switch action {
    case .optionalCounter(let action):
        
        return .none
        
    case .toggleOptionalCounter:
        
        state.counter = state.counter == nil ? CounterState() : nil
        
        return .none
    }
}
    .combined(with: counterReducer
                .optional()
                .pullback(state: \.counter, action: /OptionalAction.optionalCounter, environment: { _ in CounterEnvironment() }))

// View

struct OptionalStateView : View {

    // public final class Store<State, Action>
    let store: Store<OptionalState, OptionalAction>
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            
            VStack {

                
                
                IfLetStore(self.store.scope(state: \.counter, action: OptionalAction.optionalCounter),
                           then: { store in
                                CounterView(store: store)
                            },
                           else: {
                                Text(template: "`CounterState` is `nil`", .body)
                    
                }
                )
                
                
                


                Button {
                    viewStore.send(.toggleOptionalCounter)
                } label: {
                    Text("Show Counter")
                }
                
            }
            
        }
    }
}


struct OptionalStateView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
        OptionalStateView(store: .init(initialState: .init(),
                                       reducer: optionalStateReducer,
                                       environment: OptionalEnv())
        
        )
    }
  }
}

import SwiftUI

extension Text {
  init(template: String, _ style: Font.TextStyle) {
    enum Style: Hashable {
      case code
      case emphasis
      case strong
    }

    var segments: [Text] = []
    var currentValue = ""
    var currentStyles: Set<Style> = []

    func flushSegment() {
      var text = Text(currentValue)
      if currentStyles.contains(.code) {
        text = text.font(.system(style, design: .monospaced))
      }
      if currentStyles.contains(.emphasis) {
        text = text.italic()
      }
      if currentStyles.contains(.strong) {
        text = text.bold()
      }
      segments.append(text)
      currentValue.removeAll()
    }

    for character in template {
      switch character {
      case "*":
        flushSegment()
        currentStyles.toggle(.strong)
      case "_":
        flushSegment()
        currentStyles.toggle(.emphasis)
      case "`":
        flushSegment()
        currentStyles.toggle(.code)
      default:
        currentValue.append(character)
      }
    }
    flushSegment()

    self = segments.reduce(Text(""), +)
  }
}

extension Set {
  fileprivate mutating func toggle(_ element: Element) {
    if self.contains(element) {
      self.remove(element)
    } else {
      self.insert(element)
    }
  }
}
