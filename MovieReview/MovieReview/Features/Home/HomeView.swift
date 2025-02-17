//
//  HomeView.swift
//  MovieReview
//
//  Created by Jaehwi Kim on 2/13/25.
//

import SwiftUI
import ComposableArchitecture

@ViewAction(for: HomeFeature.self)
struct HomeView: View {
    let store: StoreOf<HomeFeature>
    
    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                carouselView
                topTabBarView
                Spacer()
            }
        }
        .onAppear {
            send(.onAppear)
        }
    }
}

private extension HomeView {
    var carouselView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 8) {
                ForEach(1..<11) { number in
                    Text(String(number))
                        .font(.largeTitle)
                        .frame(height: 205)
                        .frame(width: UIScreen.main.bounds.width - 56)
                        .background(Color.purple.opacity(0.3))
                        .clipShape(RoundedRectangle(cornerRadius: 28))
                }
            }
            .padding(.horizontal, 16)
            .scrollTargetLayout()
        }
        .scrollTargetBehavior(.viewAligned)
        .padding(.vertical, 8)
    }
    
    var topTabBarView: some View {
        VStack(alignment: .center, spacing: 0) {
            HStack(alignment: .center, spacing: 0) {
                ForEach(HomeFeature.Tab.allCases, id: \.self) { tab in
                    Button {
                        send(.selectTab(tab))
                    } label: {
                        Text(tab.rawValue)
                            .padding(.bottom, 11)
                            .overlay(
                                Rectangle()
                                    .frame(height: 2)
                                    .foregroundStyle(store.currentTab == tab ? Color.red : Color.clear),
                                alignment: .bottom
                            )
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            
            TabView(selection: Binding(
                get: { store.currentTab },
                set: { send(.selectTab($0)) }
            )) {
                Image(.prographyLogo)
                    .frame(height: 205)
                    .frame(width: 300)
                    .background(Color.purple.opacity(0.3))
                    .tag(HomeFeature.Tab.nowPlaying)
                
                Text("popular")
                .tag(HomeFeature.Tab.popular)
                
                Text("topRated")
                .tag(HomeFeature.Tab.topRated)
            }
            .frame(height: 500)
            .tint(.prographyRed)
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
    }
}
