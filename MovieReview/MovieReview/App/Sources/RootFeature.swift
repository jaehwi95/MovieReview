//
//  RootFeature.swift
//  MovieReview
//
//  Created by Jaehwi Kim on 2/14/25.
//

import ComposableArchitecture

@Reducer
struct RootFeature {
    @Dependency(\.movieClient) var movieClient
    
    enum Tab: Equatable, Hashable { case home, myPage }
    
    @ObservableState
    struct State {
        var currentTab: Tab = .home
        var home = HomeFeature.State()
        var myPage = MyPageFeature.State()
        var path = StackState<Path.State>()
    }
    
    @Reducer
    enum Path {
        case home(HomeFeature)
        case myPage(MyPageFeature)
    }
    
    enum Action: ViewAction {
        case home(HomeFeature.Action)
        case myPage(MyPageFeature.Action)
        case path(StackActionOf<Path>)
        case print(NowPlayingResult)
        case view(View)
        
        @CasePathable
        enum View: Equatable {
            case selectTab(Tab)
            case onAppear
        }
    }
    
    var body: some ReducerOf<Self> {
        Scope(state: \.home, action: \.home) {
            HomeFeature()
        }
        Scope(state: \.myPage, action: \.myPage) {
            MyPageFeature()
        }
        
        Reduce { state, action in
            switch action {
            case .home, .myPage:
                return .none
            case .path:
                return .none
            case .print(let nowPlayingResult):
                print(nowPlayingResult)
                return .none
            case .view(.selectTab(let newTab)):
                state.currentTab = newTab
                return .none
            case .view(.onAppear):
                return .run { send in
                    await send(getNowPlayingMovies())
                }
            }
        }
    }
}

private extension RootFeature {
    func getNowPlayingMovies() async -> Action {
        let result = await movieClient.nowPlaying()
        switch result {
        case .success(let nowPlayingMovies):
            return .print(nowPlayingMovies)
        case .failure:
            return .home(.setLoading(false))
        }
    }
}
