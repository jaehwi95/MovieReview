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
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            Image(.prographyLogo)
                                .padding(.vertical, 16)
                        }
                    }
            },
            destination: { store in
                switch store.case {
                case .main(let store):
                    MainView(store: store)
                case .home(let store):
                    HomeView(store: store)
                case .myPage(let store):
                    MyPageView(store: store)
                case .detail(let store):
                    DetailView(store: store)
                }
            }
        )
        .onAppear {
            let appearance = UINavigationBarAppearance()
            appearance.shadowColor = .clear
            appearance.backgroundColor = .prographyM3White
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}
