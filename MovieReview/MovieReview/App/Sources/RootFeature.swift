//
//  RootFeature.swift
//  MovieReview
//
//  Created by Jaehwi Kim on 2/14/25.
//

import ComposableArchitecture

@Reducer
struct RootFeature {
    @ObservableState
    struct State {
        var main = MainFeature.State()
        var path = StackState<Path.State>()
    }
    
    @Reducer
    enum Path {
        case main(MainFeature)
        case home(HomeFeature)
        case myPage(MyPageFeature)
    }
    
    enum Action {
        case main(MainFeature.Action)
        case home(HomeFeature.Action)
        case myPage(MyPageFeature.Action)
        case path(StackActionOf<Path>)
    }
    
    var body: some ReducerOf<Self> {
        Scope(state: \.main, action: \.main) {
            MainFeature()
        }
        
        Reduce { state, action in
            switch action {
            case .main, .home, .myPage:
                return .none
            case .path:
                return .none
            }
        }
    }
}
