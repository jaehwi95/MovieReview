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
    
    @ObservableState
    struct State {
        var isLoading: Bool = false
    }
    
    enum Action: ViewAction {
        case setLoading(Bool)
        case print(NowPlayingResult)
        case view(View)
        
        @CasePathable
        enum View {
            case onAppear
        }
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .setLoading(let isLoading):
                state.isLoading = isLoading
                return .none
            case .print(let nowPlayingResult):
                print(nowPlayingResult)
                return .none
            case .view(.onAppear):
                return .run { send in
                    await send(getNowPlayingMovies())
                }
            }
        }
    }
}

private extension HomeFeature {
    func getNowPlayingMovies() async -> Action {
        let result = await movieClient.nowPlaying()
        switch result {
        case .success(let nowPlayingMovies):
            return .print(nowPlayingMovies)
        case .failure:
            return .setLoading(false)
        }
    }
}
