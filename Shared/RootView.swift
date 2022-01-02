//
//  ContentView.swift
//  Shared
//
//  Created by Yosuke NAKAYAMA on 2021/12/20.
//

import Combine
import ComposableArchitecture
import UIKit
import XCTestDynamicOverlay
import SwiftUI


struct RootState {
    var custom = CustomState()
    var counter = CounterState()
    var twoCounters = TwoCountersState()
    var optional = OptionalState()
    var shared = SharedState()
}

enum RootAction {
    case custom(CustomAction)
    case counter(CounterAction)
    case twoCounters(TwoCountersAction)
    case optional(OptionalAction)
    case shared(SharedAction)
    case onAppear
}

struct RootEnvironment {
//    var date: () -> Date
//
//    var mainQueue: AnySchedulerOf<DispatchQueue>

}


let rootReducer: Reducer<RootState, RootAction, RootEnvironment> = Reducer<RootState, RootAction, RootEnvironment>
    
    .combine(
        
        .init({ state, action, env in

            switch action {
            case .onAppear:

                state = .init()

                return .none

            default:
                return .none

            }

        })
        ,
        
        customReducer.pullback(state: \RootState.custom,
                               action: /RootAction.custom,
                               environment: {_ in .init() }),

        counterReducer.pullback(state: \RootState.counter,
                                action: /RootAction.counter,
                                environment: {_ in .init() }),

        twoCountersReducer.pullback(state: \RootState.twoCounters,
                                    action: /RootAction.twoCounters,
                                    environment: {_ in .init() }),

        optionalStateReducer.pullback(state: \RootState.optional,
                                      action: /RootAction.optional,
                                      environment: {_ in .init() }),
        
        sharedStateReducer.pullback(state: \RootState.shared,
                                    action: /RootAction.shared,
                                    environment: {_ in .init() })
        
    )


struct RootView: View {
    let store: Store<RootState, RootAction>
    
    var body: some View {

        WithViewStore(self.store.stateless) { viewStore in
            NavigationView {
                List {
                    NavigationLink("Custom") {
                        CustomView(store: self.store.scope(state: \RootState.custom, action: RootAction.custom))
                    }
                    
                    NavigationLink("Counter") {
                        
                        CounterView(store:
                                        
                                        self.store.scope(state: \RootState.counter, action: RootAction.counter)
                        )
                    }
                    
                    NavigationLink("Two Counters") {
                        TwoCountersView(store:
                                            self.store.scope(state: \RootState.twoCounters, action: RootAction.twoCounters)
                        )
                        
                    }
                    
                    NavigationLink("Optional Counters") {
                        OptionalStateView(store:
                                            self.store.scope(state: \RootState.optional, action: RootAction.optional)
                        )

                    }
                    
                    NavigationLink("Shared States") {
                        SharedStateView(store:
                                            self.store.scope(state: \RootState.shared, action: RootAction.shared)
                        )

                    }
                    
                }
                .navigationTitle("TCA Sample List")
                
            }
            .onAppear {
                viewStore.send(.onAppear)
            }
            
        }
        }
}



struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(store: Store(initialState: RootState(),
                              reducer: rootReducer,
                              environment: RootEnvironment()))
            .environment(\.colorScheme, .dark)
    }
}
