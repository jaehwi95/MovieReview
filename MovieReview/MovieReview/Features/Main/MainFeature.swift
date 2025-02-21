//
//  MainFeature.swift
//  MovieReview
//
//  Created by Jaehwi Kim on 2/16/25.
//

import ComposableArchitecture

@Reducer
struct MainFeature {
    enum Tab { case home, myPage }
    
    @ObservableState
    struct State {
        var currentTab: Tab = .home
        var home = HomeFeature.State()
        var myPage = MyPageFeature.State()
    }
    
    enum Action: ViewAction {
        case home(HomeFeature.Action)
        case myPage(MyPageFeature.Action)
        case view(View)
        
        @CasePathable
        enum View {
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
            case .view(.selectTab(let tab)):
                state.currentTab = tab
                return .none
            }
        }
    }
}
