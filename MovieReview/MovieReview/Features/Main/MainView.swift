//
//  MainView.swift
//  MovieReview
//
//  Created by Jaehwi Kim on 2/16/25.
//

import SwiftUI
import ComposableArchitecture

@ViewAction(for: MainFeature.self)
struct MainView: View {
    let store: StoreOf<MainFeature>
    
    var body: some View {
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
            .tag(MainFeature.Tab.home)
            
            MyPageView(
                store: store.scope(state: \.myPage, action: \.myPage)
            )
            .tabItem {
                Image(systemName: "person")
            }
            .tag(MainFeature.Tab.myPage)
        }
    }
}
