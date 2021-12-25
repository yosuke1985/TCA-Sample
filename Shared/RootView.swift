//
//  ContentView.swift
//  Shared
//
//  Created by Yosuke NAKAYAMA on 2021/12/20.
//

import SwiftUI
import ComposableArchitecture

struct RootView: View {
    let store: Store<RootState, RootAction>
    
    var body: some View {

        WithViewStore(self.store.stateless) { viewStore in
            NavigationView {
                List {
                    NavigationLink("Custom") {
                        CustomView(store: self.store.scope(state: \.custom, action: RootAction.custom))
                    }
                    
                    NavigationLink("Counter") {
                        
                        CounterView(store:
                                        
                                        self.store.scope(state: \.counter, action: RootAction.counter)
                        )
                    }
                    
                    NavigationLink("Two Counters") {
                        TwoCountersView(store:
                                            self.store.scope(state: \.twoCounters, action: RootAction.twoCounters)
                        )
                        
                    }
                    
                    NavigationLink("Optional Counters") {
                        OptionalStateView(store:
                                            self.store.scope(state: \.optional, action: RootAction.optional)
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
