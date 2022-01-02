//
//  SharedState.swift
//  SampleAppOfTCA
//
//  Created by Yosuke NAKAYAMA on 2021/12/28.
//

import Foundation
import SwiftUI
import ComposableArchitecture


// SharedState
struct SharedState: Equatable {
    var counter: CounterState = CounterState()
    
}


// Action


enum SharedAction {
    
}


// Env

struct SharedEnv {}


// Reducer

let sharedStateReducer = Reducer<SharedState, SharedAction, SharedEnv> { state, action, env in
    
    
    return .none
    
}


struct SharedStateView : View {
    let store:Store<SharedState, SharedAction>
    
    var body: some View {
        VStack {
            Text("")
        }
    }
    
}


struct SharedStateView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SharedStateView(store: .init(initialState: .init(),
                                           reducer: sharedStateReducer,
                                           environment: SharedEnv())
                              
            )
        }
    }
}
