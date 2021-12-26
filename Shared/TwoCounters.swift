//
//  TwoCounters.swift
//  SampleAppOfTCA
//
//  Created by Yosuke NAKAYAMA on 2021/12/21.
//

import Foundation
import SwiftUI
import ComposableArchitecture

// State

struct TwoCountersState: Equatable {
    var counter1: CounterState = CounterState()
    var counter2: CounterState = CounterState()
}

// Action

enum TwoCountersAction {
    case counter1(CounterAction)
    case counter2(CounterAction)
}

// Environment

struct TwoCountersEnvironment {}

// Reducer
// public struct Reducer<State, Action, Environment>


let twoCountersReducer = Reducer<TwoCountersState, TwoCountersAction,TwoCountersEnvironment>
    .combine(
        counterReducer.pullback(state: \TwoCountersState.counter1,
                                          action: /TwoCountersAction.counter1,
                                          environment:{ _ in CounterEnvironment() } )
        ,
        counterReducer.pullback(state: \TwoCountersState.counter2,
                                          action: /TwoCountersAction.counter2,
                                          environment: { _ in CounterEnvironment() } )
    )

struct TwoCountersView : View {

    // public final class Store<State, Action>
    let store: Store<TwoCountersState, TwoCountersAction>
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            VStack {
                CounterView(
                  store: self.store.scope(state: \TwoCountersState.counter1,
                                          action: TwoCountersAction.counter1)
                )
                CounterView(
                  store: self.store.scope(state: \TwoCountersState.counter2,
                                          action: TwoCountersAction.counter2)
                )
            }
        }

    }
}


struct TwoCountersView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
        TwoCountersView(store: .init(initialState: .init(),
                                     reducer: twoCountersReducer,
                                     environment: .init()))
    }
  }
}


