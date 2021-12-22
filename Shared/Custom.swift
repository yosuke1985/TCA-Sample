//
//  SampleView.swift
//  SampleAppOfTCA
//
//  Created by Yosuke NAKAYAMA on 2021/12/20.
//

import Foundation
import ComposableArchitecture
import SwiftUI


// State

struct CustomState: Equatable {
    var count: Int = 0
    var alert: AlertState<CustomAction>?
    var confirmDialog: ConfirmationDialogState<CustomAction>?
    var inputText: String = ""
    @BindableState var toggleBool: Bool = false
}

// Action

enum CustomAction: Equatable, BindableAction {
    case binding(BindingAction<CustomState>)
    case counterButtonTapped
    case showConfirmation
    case dissmissShowConfirmation
    case showAlert
    case alertDismissed
    case inputTextField(String)
}

// Environment

struct CustomEnvironment {}

// Reducer

let customReducer = Reducer<CustomState, CustomAction, CustomEnvironment> {
    state, action, env in
 
    switch action {
    case .counterButtonTapped:
        
        state.count += 1
        return .none
    
    case .showConfirmation:
//        state.confirmDialog = .init(title: .init("Confirm"))

        state.confirmDialog = .init(
          title: .init("Confirmation dialog"),
          message: .init("This is a confirmation dialog."),
          buttons: [
            .cancel(.init("Cancel"))
//            ,
//            .default(.init("Increment"), action: .send(.incrementButtonTapped)),
//            .default(.init("Decrement"), action: .send(.decrementButtonTapped)),
          ]
        )
        return .none
        
        
    case .dissmissShowConfirmation:
        state.confirmDialog = nil
        return .none
        
    case .showAlert:
        state.alert = .init(title: .init("Wow!@"))
        
        return .none
        
    case .alertDismissed:
        state.alert = nil
        
        return .none
        
    case .inputTextField(let inputText):
        state.inputText = inputText
        return .none
        
    case .binding(_):
        return .none
    }
}
    .binding()


// View

struct CustomView: View {
    let store: Store<CustomState, CustomAction>
    @State var flag = false
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            VStack {
                VStack {
                    Text("\(viewStore.count)")
                                    
                    Button {
                        viewStore.send(.counterButtonTapped)
                    } label: {
                        Text("Tap Me!")
                    }
                    .padding()

                    Divider()
                    
                    Button {
                        viewStore.send(.showConfirmation)
                    } label: {
                        Text("Show Confirmation")
                    }
                    
                    Divider()
                    
                    Button {
                        viewStore.send(.showAlert)
                    } label: {
                        Text("Show Alert")
                    }
                    
                    Divider()
                    
                    Text("\(viewStore.inputText)")
                    
                    TextField("Type here",
                              text: viewStore.binding(get: \.inputText, send: CustomAction.inputTextField))
                        .padding()
                }
                .disabled(viewStore.toggleBool)

                
                
                VStack {
                    Divider()

                    Toggle("Disabled", isOn: viewStore.binding(\.$toggleBool))
                }
                
                VStack {
                    
                }
 

            }

            .alert(self.store.scope(state: \.alert),
                   dismiss: .alertDismissed)
            
            .confirmationDialog(
              self.store.scope(state: \.confirmDialog),
              dismiss: .dissmissShowConfirmation
            )
       
        }
      
    }
}

struct CustomView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
//      BindingBasicsView(
//        store: Store(
//          initialState: BindingBasicsState(),
//          reducer: bindingBasicsReducer,
//          environment: BindingBasicsEnvironment()
//        )
//      )
        
        CustomView(store: Store<CustomState, CustomAction>(initialState: .init(),
                                                                 reducer: customReducer,
                                                                 environment: .init()))
    }
  }
}


