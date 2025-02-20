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
        case detail(DetailFeature)
    }
    
    enum Action {
        case main(MainFeature.Action)
        case path(StackActionOf<Path>)
    }
    
    var body: some ReducerOf<Self> {
        Scope(state: \.main, action: \.main) {
            MainFeature()
        }
        
        Reduce { state, action in
            switch action {
            case .main(let mainAction):
                switch mainAction {
                case .home(let homeAction):
                    switch homeAction {
                    case .view(.onMovieTapped(let movieItem)):
                        state.path.append(.detail(DetailFeature.State(movieID: movieItem.id)))
                        return .none
                    default:
                        return .none
                    }
                case .myPage(let myPageAction):
                    switch myPageAction {
                    case .view(.onMovieTapped(let movieItem)):
                        if let movieID = Int(movieItem.movieID) {
                            state.path.append(.detail(DetailFeature.State(movieID: movieID)))
                        }
                        return .none
                    default:
                        return .none
                    }
                default:
                    return .none
                }
            case .path(.element(_, .detail(.view(.onBackButtonTapped)))):
                state.path.removeLast()
                return .none
            case .path:
                return .none
            }
        }
        .forEach(\.path, action: \.path)
    }
}
