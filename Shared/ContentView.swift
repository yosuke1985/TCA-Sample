//
//  ContentView.swift
//  Shared
//
//  Created by Yosuke NAKAYAMA on 2021/12/20.
//

import SwiftUI
import ComposableArchitecture

struct ContentView: View {
    var body: some View {
//        Text("Hello, world!")
//            .padding()
        
        NavigationView {
            List {
                NavigationLink("Sample 1") {
                    SampleView(store: Store<CustomState, CustomAction>(initialState: .init(),
                                                                             reducer: customReducer,
                                                                             environment: .init()))
                }
                
                NavigationLink("Counter") {
                    CounterView(store: .init(initialState: CounterState(),
                                             reducer: counterReducer,
                                             environment: .init()))
                }
                
                NavigationLink("Two Counters") {
                    TwoCountersView(store: .init(initialState: TwoCountersState(), reducer: twoCountersReducer, environment: TwoCountersEnvironment()))
                    
                }
                
            }
            .navigationTitle("TCA Sample List")
 
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.colorScheme, .dark)
    }
}
