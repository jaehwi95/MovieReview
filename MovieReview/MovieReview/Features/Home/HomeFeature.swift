//
//  HomeFeature.swift
//  MovieReview
//
//  Created by Jaehwi Kim on 2/13/25.
//

import ComposableArchitecture

@Reducer
struct HomeFeature {
    @Dependency(\.movieClient) var movieClient
    enum Tab: String, CaseIterable {
        case nowPlaying = "Now Playing"
        case popular = "Popular"
        case topRated = "Top Rated"
    }
    
    @ObservableState
    struct State {
        var isLoading: Bool = false
        var currentTab: Tab = .nowPlaying
    }
    
    enum Action: ViewAction {
        case setLoading(Bool)
        case view(View)
        
        @CasePathable
        enum View {
            case onAppear
            case selectTab(Tab)
        }
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .setLoading(let isLoading):
                state.isLoading = isLoading
                return .none
            case .view(.onAppear):
                return .run { send in
                    await send(getNowPlayingMovies())
                }
            case .view(.selectTab(let tab)):
                state.currentTab = tab
                return .none
            }
        }
    }
}

private extension HomeFeature {
    func getNowPlayingMovies() async -> Action {
        let result = await movieClient.nowPlaying()
        switch result {
        case .success(let nowPlayingMovies):
            print(nowPlayingMovies)
            return .setLoading(false)
        case .failure:
            return .setLoading(false)
        }
    }
}
