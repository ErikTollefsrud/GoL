//
//  ConfigurationView.swift
//  SwiftUIGameOfLife
//
//  Created by Van Simmons on 5/31/20.
//  Copyright © 2020 ComputeCycles, LLC. All rights reserved.
//
import SwiftUI
import Combine
import ComposableArchitecture
import Configurations
import Configuration


public struct ConfigurationsView: View {
    let store: Store<ConfigurationsState, ConfigurationsState.Action>
    let viewStore: ViewStore<ConfigurationsState, ConfigurationsState.Action>
    
    public init(store: Store<ConfigurationsState, ConfigurationsState.Action>) {
        self.store = store
        self.viewStore = ViewStore(store, removeDuplicates: ==)
        UITableView.appearance().backgroundColor = .clear
    }
    
    public var body: some View {
        // Your problem 3A code starts here.
        NavigationView {
            VStack {
                List {
                    ForEachStore(
                        self.store.scope(
                            state: \.configs,
                            action: ConfigurationsState.Action.configuration(index:action:)
                        ),
                        content: ConfigurationView.init(store:)
                    ).listRowBackground(Color("configurationBackground"))
                }
                
                Divider()
                    .padding(8.0)
                
                HStack {
                    Spacer()
                    Button(action: {
                        self.viewStore.send(.fetch)
                    }) {
                        Text("Fetch").font(.system(size: 24.0))
                    }
                    .padding([.top, .bottom], 8.0)
                    
                    Spacer()
                    
                    Button(action: {
                        self.viewStore.send(.clear)
                    }) {
                        Text("Clear").font(.system(size: 24.0))
                    }
                    .padding([.top, .bottom], 8.0)
                    
                    Spacer()
                }
                    //.background(Color("configurationBackground").edgesIgnoringSafeArea(.all))
                .padding([.top, .bottom], 8.0)
            }.navigationBarTitle(Text("Configurations"))
                .background(Color("configurationBackground").edgesIgnoringSafeArea(.all))
                // Problem 5a goes here
                .sheet(
                    isPresented: self.viewStore.binding(
                        get: { $0.isAdding },
                        send: ConfigurationsState.Action.stopAdding),
                    onDismiss: { },
                    content: { AddConfigurationView(store: self.store.scope(
                        state: { $0.addConfigState },
                        action: ConfigurationsState.Action.addConfigAction(action:)
                        )
                        )
                })
                // Problem 3B begins here
                // Problem 5b Goes here
                .navigationBarItems(trailing: Button("Add") {
                    self.viewStore.send(.add)
                })
                // Problem 3A ends here
                .navigationBarHidden(false)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

public struct ConfigurationsView_Previews: PreviewProvider {
    static let previewState = ConfigurationsState()
    public static var previews: some View {
        ConfigurationsView(
            store: Store(
                initialState: previewState,
                reducer: configurationsReducer,
                environment: ConfigurationsEnvironment()
            )
        )
    }
}
