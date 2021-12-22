//
//  SampleAppOfTCAApp.swift
//  Shared
//
//  Created by Yosuke NAKAYAMA on 2021/12/20.
////
//


import SwiftUI
import ComposableArchitecture

@main
struct SampleAppOfTCAApp: App {
    var body: some Scene {
        WindowGroup {
            RootView(store: Store(initialState: RootState(),
                                  reducer: rootReducer,
                                  environment: RootEnvironment()))

        }
    }
}
