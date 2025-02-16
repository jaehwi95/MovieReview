//
//  RootView.swift
//  MovieReview
//
//  Created by Jaehwi Kim on 2/14/25.
//

import SwiftUI
import ComposableArchitecture

struct RootView: View {
    @Bindable var store: StoreOf<RootFeature>
    
    var body: some View {
        NavigationStack(
            path: $store.scope(state: \.path, action: \.path),
            root: {
                MainView(store: store.scope(state: \.main, action: \.main))
            },
            destination: { store in
                switch store.case {
                case .main(let store):
                    MainView(store: store)
                case .home(let store):
                    HomeView(store: store)
                case .myPage(let store):
                    MyPageView(store: store)
                }
            }
        )
    }
}

#Preview {
    RootView(store: Store(initialState: RootFeature.State(), reducer: {
        RootFeature()
    }))
}
