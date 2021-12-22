//
//  Core.swift
//  SampleAppOfTCA
//
//  Created by Yosuke NAKAYAMA on 2021/12/22.
//

import Combine
import ComposableArchitecture
import UIKit
import XCTestDynamicOverlay


struct RootState {
    var custom = CustomState()
    var counter = CounterState()
    var twoCounters = TwoCountersState()
    var optional = OptionalState()
}

enum RootAction {
    case custom(CustomAction)
    case counter(CounterAction)
    case twoCounters(TwoCountersAction)
    case optional(OptionalAction)
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
        customReducer.pullback(state: \.custom,
                               action: /RootAction.custom,
                               environment: {_ in .init() }),

        counterReducer.pullback(state: \.counter,
                                action: /RootAction.counter,
                                environment: {_ in .init() }),

        twoCountersReducer.pullback(state: \.twoCounters,
                                    action: /RootAction.twoCounters,
                                    environment: {_ in .init() }),

        optionalStateReducer.pullback(state: \.optional,
                                      action: /RootAction.optional,
                                      environment: {_ in .init() })
        
    )
