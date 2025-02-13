//
//  RootView.swift
//  MovieReview
//
//  Created by Jaehwi Kim on 2/14/25.
//

import SwiftUI
import ComposableArchitecture

@ViewAction(for: RootFeature.self)
struct RootView: View {
    @Bindable var store: StoreOf<RootFeature>
    
    var body: some View {
        NavigationStack(
            path: $store.scope(state: \.path, action: \.path),
            root: {
                TabView(selection: Binding(
                    get: { store.currentTab },
                    set: { send(.selectTab($0)) }
                )) {
                    HomeView(
                        store: store.scope(state: \.home, action: \.home)
                    )
                    .tabItem {
                        Image(systemName: "house")
                    }
                    .tag(RootFeature.Tab.home)
                    
                    MyPageView(
                        store: store.scope(state: \.myPage, action: \.myPage)
                    )
                    .tabItem {
                        Image(systemName: "person")
                    }
                    .tag(RootFeature.Tab.myPage)
                }
            },
            destination: { store in
                switch store.case {
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
