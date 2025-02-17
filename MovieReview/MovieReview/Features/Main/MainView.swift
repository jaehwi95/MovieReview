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
            Group {
                HomeView(
                    store: store.scope(state: \.home, action: \.home)
                )
                .tabItem {
                    tabItem(
                        labelText: "HOME",
                        selectedImageResource: .prographyHouseSelected,
                        unselectedImageResource: .prographyHouse,
                        isSelcted: store.currentTab == .home
                    )
                }
                .tag(MainFeature.Tab.home)
                
                MyPageView(
                    store: store.scope(state: \.myPage, action: \.myPage)
                )
                .tabItem {
                    tabItem(
                        labelText: "MY",
                        selectedImageResource: .prographyStarSelected,
                        unselectedImageResource: .prographyStar,
                        isSelcted: store.currentTab == .myPage
                    )
                }
                .tag(MainFeature.Tab.myPage)
            }
        }
        .tint(.prographyRed)
        .onAppear {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithOpaqueBackground()
            tabBarAppearance.shadowColor = .clear
            tabBarAppearance.backgroundColor = .prographyGray6
            
            let tabBar = UITabBar.appearance()
            tabBar.standardAppearance = tabBarAppearance
            tabBar.scrollEdgeAppearance = tabBarAppearance
        }
    }
}

private extension MainView {
    func tabItem(
        labelText: String,
        selectedImageResource: ImageResource,
        unselectedImageResource: ImageResource,
        isSelcted: Bool
    ) -> some View {
        return VStack(spacing: 4) {
            Image(isSelcted ? selectedImageResource : unselectedImageResource)
                .resizable()
                .frame(width: 24, height: 24)
                .padding(.vertical, 4)
            Text(labelText)
                .font(PrographyFont.pretendardMedium12)
                .foregroundStyle(.prographyOnSurfaceVariant)
        }
    }
}
