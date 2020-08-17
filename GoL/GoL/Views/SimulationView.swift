//
//  SimulationView.swift
//  SwiftUIGameOfLife
//
//  Created by Van Simmons on 5/31/20.
//  Copyright © 2020 ComputeCycles, LLC. All rights reserved.
//
import SwiftUI
import ComposableArchitecture
import Simulation
import Grid

public struct SimulationView: View {
    let store: Store<SimulationState, SimulationState.Action>

    public init(store: Store<SimulationState, SimulationState.Action>) {
        self.store = store
    }

    public var body: some View {
        NavigationView {
            WithViewStore(store) { viewStore in
                VStack {
                    GeometryReader { g in
                        if g.size.width < g.size.height {
                            self.verticalContent(for: viewStore, geometry: g)
                        } else {
                            self.horizontalContent(for: viewStore, geometry: g)
                        }
                    }
                }
                .navigationViewStyle(StackNavigationViewStyle())
                .navigationBarHidden(false)
                .navigationBarTitle("Simulation")
                    // Problem 6 - your answer goes here.
                    .onAppear {
                    viewStore.shouldRestartTimer ?
                        viewStore.send(.startTimer) :
                        viewStore.send(.stopTimer)
                }
                .onDisappear {
                    viewStore.state.isRunningTimer ?
                        viewStore.send(.setShouldRestartTimer(true)) :
                        viewStore.send(.setShouldRestartTimer(false))
                    
                    viewStore.send(.stopTimer)
                }
            }
            .background(Color("simulationBackground").edgesIgnoringSafeArea(.all))
        }
        .navigationViewStyle(StackNavigationViewStyle())
    
    }

    func verticalContent(
        for viewStore: ViewStore<SimulationState, SimulationState.Action>,
        geometry g: GeometryProxy
    ) -> some View {
        VStack {
            InstrumentationView(
                store: self.store,
                width: g.size.width * 0.82
            )
            .frame(height: g.size.height * 0.35)
            .padding(.bottom, 16.0)

            Divider()

            EmptyView()
                .modifier(
                    GridAnimationModifier(
                        store: self.store.scope(
                            state: \.gridState,
                            action: SimulationState.Action.grid(action:)),
                        fractionComplete: viewStore.isAtStartOfAnimation ? 0.0 : 1.0
                )
            )
        }
    }

    func horizontalContent(
        for viewStore: ViewStore<SimulationState, SimulationState.Action>,
        geometry g: GeometryProxy
    ) -> some View {
        HStack {
            Spacer()
            InstrumentationView(store: self.store)
            Spacer()
            Divider()
            EmptyView()
                .modifier(
                    GridAnimationModifier(
                        store: self.store.scope(
                            state: \.gridState,
                            action: SimulationState.Action.grid(action:)),
                        fractionComplete: viewStore.isAtStartOfAnimation ? 0.0 : 1.0
                )
            )
            .frame(width: g.size.height)
            Spacer()
        }
    }
}

public struct SimulationView_Previews: PreviewProvider {
    static let previewState = SimulationState()
    public static var previews: some View {
        SimulationView(
            store: Store(
                initialState: previewState,
                reducer: simulationReducer,
                environment: SimulationEnvironment()
            )
        )
    }
}
