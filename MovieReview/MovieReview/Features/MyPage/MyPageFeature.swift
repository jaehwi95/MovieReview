//
//  MyPageFeature.swift
//  MovieReview
//
//  Created by Jaehwi Kim on 2/13/25.
//

import ComposableArchitecture

@Reducer
struct MyPageFeature: Reducer {
    enum RatingOption: String, Selectable {
        case all = "All"
        case five = "Five"
        case four = "Four"
        case three = "Three"
        case two = "Two"
        case one = "One"
        case zero = "Zero"
    }
    
    @ObservableState
    struct State {
        var savedMovies: [LocalMovieData] = []
        var filteredMovies: [LocalMovieData] = []
        var selectedOption: RatingOption = .all
    }
    
    enum Action: ViewAction, BindableAction {
        case view(View)
        case binding(BindingAction<State>)
        
        @CasePathable
        enum View {
            case onAppear
            case onMovieTapped(LocalMovieData)
        }
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .view(.onAppear):
                let savedMovies = LocalMovieProvider.loadSavedMovies()
                state.savedMovies = savedMovies
                state.filteredMovies = savedMovies
                return .none
            case .view(.onMovieTapped):
                return .none
            case .binding(\.selectedOption):
                switch state.selectedOption {
                case .all:
                    state.filteredMovies = state.savedMovies
                case .five:
                    state.filteredMovies = state.savedMovies.filter {
                        $0.starRating == 5
                    }
                case .four:
                    state.filteredMovies = state.savedMovies.filter {
                        $0.starRating == 4
                    }
                case .three:
                    state.filteredMovies = state.savedMovies.filter {
                        $0.starRating == 3
                    }
                case .two:
                    state.filteredMovies = state.savedMovies.filter {
                        $0.starRating == 2
                    }
                case .one:
                    state.filteredMovies = state.savedMovies.filter {
                        $0.starRating == 1
                    }
                case .zero:
                    state.filteredMovies = state.savedMovies.filter {
                        $0.starRating == 0
                    }
                }
                return .none
            case .binding:
                return .none
            }
        }
    }
}

