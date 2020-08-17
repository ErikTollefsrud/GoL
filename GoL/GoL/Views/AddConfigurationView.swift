//
//  AddConfigurationView.swift
//  FinalProject
//
//  Created by Van Simmons on 7/25/20.
//  Copyright © 2020 ComputeCycles, LLC. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import Configurations
import Combine

struct AddConfigurationView: View {
    var store: Store<AddConfigState, AddConfigState.Action>
    @ObservedObject var viewStore: ViewStore<AddConfigState, AddConfigState.Action>
    @State private var keyboardHeight: CGFloat = 0
    
    init(store: Store<AddConfigState, AddConfigState.Action>) {
        self.store = store
        self.viewStore = ViewStore(store)
    }
    var body: some View {
        GeometryReader { proxy in
            VStack {
                VStack {
                    //Problem 5C Goes inside the following HStacks...
                    VStack {
                        HStack {
                            
                            Text("Title:")
                                .foregroundColor(Color.gray)
                                .padding(.trailing, 8.0)
                                .frame(width: proxy.size.width * 0.2, alignment: .trailing)
                            Spacer()
                            TextField("", text: self.viewStore.binding(
                                get: \.title,
                                send: AddConfigState.Action.updateTitle))
                                .foregroundColor(Color("accent"))
                            Spacer()
                        }
                        HStack {
                            Text("Size:")
                                .foregroundColor(Color.gray)
                                .padding(.trailing, 8.0)
                                .frame(width: proxy.size.width * 0.2, alignment: .trailing)
                            Spacer()
                            Button("-") { self.viewStore.send(.counterStateAction(action: .decrementButtonTapped)) }
                            Text("\(self.viewStore.counterState.count)")
                            Button("+") { self.viewStore.send(.counterStateAction(action: .incrementButtonTapped)) }
                            Spacer()
                        }
                    }
                    .padding()
                    .overlay(Rectangle().stroke(Color.gray, lineWidth: 2.0))
                    .padding(.bottom, 24.0)
                    
                    HStack {
                        Spacer()
                        // Problem 5D - your answer goes in the following buttons
                        ThemedButton(text: "Save") {
                            self.viewStore.send(.ok)
                        }
                        ThemedButton(text: "Cancel") {
                            self.viewStore.send(.cancel)
                        }
                        Spacer()
                    }
                        // Problem 5E - Your answer goes here.
                        .padding(.bottom, self.keyboardHeight)
                        .onReceive(Publishers.keyboardHeight) {
                            self.keyboardHeight = $0
                    }
                    
                }
                .font(.title)
                .frame(width: proxy.size.width * 0.75)
                .animation(.easeInOut)
            }
        }
    }
}

struct AddConfigurationView_Previews: PreviewProvider {
    static var previews: some View {
        AddConfigurationView(
            store: Store<AddConfigState, AddConfigState.Action>(
                initialState: AddConfigState(
                    title: "",
                    counterState: CounterState(count: 10)
                ),
                reducer: addConfigReducer,
                environment: AddConfigEnvironment()
            )
        )
    }
}
