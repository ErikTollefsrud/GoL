//
//  StatisticsView.swift
//  SwiftUIGameOfLife
//
//  Created by Van Simmons on 5/31/20.
//  Copyright © 2020 ComputeCycles, LLC. All rights reserved.
//
import SwiftUI
import ComposableArchitecture
import Statistics

public struct StatisticsView: View {
    let store: Store<StatisticsState, StatisticsState.Action>
    let viewStore: ViewStore<StatisticsState, StatisticsState.Action>

    public init(store: Store<StatisticsState, StatisticsState.Action>) {
        self.store = store
        self.viewStore = ViewStore(store)
    }
    
    public var body: some View {
        NavigationView {
            GeometryReader { g in
                VStack {
                    self.steps(width: g.size.width * 0.9)
                        .frame(width: g.size.width * 0.9, alignment: .center)
                        .fixedSize(horizontal: true, vertical: false)
                        .padding(.bottom, 0.0)

                    self.alive(width: g.size.width * 0.9)
                        .frame(width: g.size.width * 0.9, alignment: .center)
                        .fixedSize(horizontal: true, vertical: false)
                        .padding(.bottom, 0.0)

                    self.born(width: g.size.width * 0.9)
                        .frame(width: g.size.width * 0.9, alignment: .center)
                        .fixedSize(horizontal: true, vertical: false)
                        .padding(.bottom, 0.0)

                    self.died(width: g.size.width * 0.9)
                        .frame(width: g.size.width * 0.9, alignment: .center)
                        .fixedSize(horizontal: true, vertical: false)
                        .padding(.bottom, 0.0)

                    self.empty(width: g.size.width * 0.9)
                        .frame(width: g.size.width * 0.9, alignment: .center)
                        .fixedSize(horizontal: true, vertical: false)
                        .padding(.bottom, 12.0)

                    Button(action: {
                        self.viewStore.send(.reset)
                    }) {
                        Text("Reset")
                    }
                    .frame(alignment: .center)
                }
                .frame(width: g.size.width * 0.9, alignment: .center)
                .fixedSize(horizontal: true, vertical: false)
            }
            .navigationBarTitle(Text("Statistics"))
            .background(Color("statisticsBackground").edgesIgnoringSafeArea(.all))
        }
        .navigationViewStyle(StackNavigationViewStyle())
    .onDisappear() // fixes odd crash when switching between stats view. Not sure why. :/
        // Discovered this "fix" when trying to debug and troubleshoot why it's happening.s
    }

    var title: some View {
        HStack {
            Text("Statistics")
                .font(.system(size: 48))
                .bold()
                .foregroundColor(Color("accent"))
        }
    }

    func steps(width: CGFloat) -> some View {
        HStack {
            Text("Steps:")
                .font(.system(size: 24))
                .bold()
                .foregroundColor(.secondary)
                .frame(width: width * 0.25, alignment: .trailing)

            Text("\(self.viewStore.statistics.steps)")
                .font(.system(size: 24))
                .bold()
                .foregroundColor(.secondary)
                .frame(width: width * 0.7, alignment: .trailing)

            Spacer()
        }
    }

    func alive(width: CGFloat) -> some View {
        HStack {
            Text("Alive:")
                .font(.system(size: 24))
                .bold()
                .foregroundColor(.secondary)
                .frame(width: width * 0.25, alignment: .trailing)

            Text("\(self.viewStore.statistics.alive)")
                .font(.system(size: 24))
                .bold()
                .foregroundColor(.secondary)
                .frame(width: width * 0.7, alignment: .trailing)

            Spacer()
        }
    }

    func born(width: CGFloat) -> some View {
        HStack {
            Text("Born:")
                .font(.system(size: 24))
                .bold()
                .foregroundColor(.secondary)
                .frame(width: width * 0.25, alignment: .trailing)

            Text("\(self.viewStore.statistics.born)")
                .font(.system(size: 24))
                .bold()
                .foregroundColor(.secondary)
                .frame(width: width * 0.7, alignment: .trailing)

            Spacer()
        }
    }

    func died(width: CGFloat) -> some View {
        HStack {
            Text("Died:")
                .font(.system(size: 24))
                .bold()
                .foregroundColor(.secondary)
                .frame(width: width * 0.25, alignment: .trailing)

            Text("\(self.viewStore.statistics.died)")
                .font(.system(size: 24))
                .bold()
                .foregroundColor(.secondary)
                .frame(width: width * 0.7, alignment: .trailing)

            Spacer()
        }
    }

    func empty(width: CGFloat) -> some View {
        HStack {
            Text("Empty:")
                .font(.system(size: 24))
                .bold()
                .foregroundColor(.secondary)
                .frame(width: width * 0.25, alignment: .trailing)

            Text("\(self.viewStore.statistics.empty)")
                .font(.system(size: 24))
                .bold()
                .foregroundColor(.secondary)
                .frame(width: width * 0.7, alignment: .trailing)

            Spacer()
        }
    }
}

public struct StatisticsView_Previews: PreviewProvider {
    static let previewState = StatisticsState()
    public static var previews: some View {
        StatisticsView(
            store: Store(
                initialState: previewState,
                reducer: statisticsReducer,
                environment: StatisticsEnvironment()
            )
        )
    }
}
