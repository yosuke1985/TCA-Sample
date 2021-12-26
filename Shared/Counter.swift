//
//  Counter.swift
//  SampleAppOfTCA
//
//  Created by Yosuke NAKAYAMA on 2021/12/20.
//

import Foundation
import SwiftUI
import ComposableArchitecture

// State

struct Counter: Equatable {
    var count: Int = 0
}

struct CounterState: Equatable {
    var counter = Counter()
}

// Action

enum CounterAction {
    case incrementButtonTapped
    case decrementButtonTapped
}

// Environment

struct CounterEnvironment {
    
}

// Recuder
//public struct Reducer<State, Action, Environment> {


let counterReducer = Reducer<CounterState, CounterAction, CounterEnvironment> { state, action, env in
    
    switch action {
    case .incrementButtonTapped:
        state.counter.count += 1
        
        return .none
        
    case .decrementButtonTapped:
        state.counter.count -= 1

        return .none
    }
}

// View
struct CounterView : View {
    // ViewStore<State, Action>
    let store: Store<CounterState, CounterAction>

    var body: some View {
        WithViewStore(self.store) { viewStore in
            VStack {
                
                Button {
                    viewStore.send(CounterAction.incrementButtonTapped)
                } label: {
                    
                    Text("+")

                }
                .padding()
                
                Text("\(viewStore.counter.count)")
                
                Button {
                    viewStore.send(CounterAction.decrementButtonTapped)

                } label: {
                    Text("-")

                    
                }
                .padding()


            }
        }
        
    }
}

struct CounterView_Previews: PreviewProvider {
    static var previews: some View {
        CounterView(store: .init(initialState: CounterState(), reducer: counterReducer, environment: CounterEnvironment()))
    }
}
