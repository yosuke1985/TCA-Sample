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
        
        SampleView(store: Store<CustomState, CustomAction>(initialState: .init(),
                                                                 reducer: customReducer,
                                                                 environment: .init()))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
