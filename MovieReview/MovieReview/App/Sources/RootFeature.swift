//
//  RootFeature.swift
//  MovieReview
//
//  Created by Jaehwi Kim on 2/14/25.
//

import ComposableArchitecture

@Reducer
struct RootFeature {
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
        case view(View)
        
        @CasePathable
        enum View: Equatable {
            case selectTab(Tab)
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
            case .view(.selectTab(let newTab)):
                state.currentTab = newTab
                return .none
            }
        }
    }
}
