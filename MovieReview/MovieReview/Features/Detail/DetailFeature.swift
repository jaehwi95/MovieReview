//
//  DetailFeature.swift
//  MovieReview
//
//  Created by Jaehwi Kim on 2/20/25.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct DetailFeature: Reducer {
    @Dependency(\.movieClient) var movieClient
    
    @ObservableState
    struct State {
        @Presents var alert: AlertState<Action.Alert>?
        var isStarRated: Bool = false
        var movieID: String? = nil
        var movieInformation: MovieInfoModel? = nil
        var starRating: Int? = nil
        var commentText: String = ""
        var commentDate: String? = nil
        
        init(movieID: Int?) {
            if let movieID = movieID {
                self.movieID = String(movieID)
            }
        }
    }
    
    enum Action: ViewAction, BindableAction {
        case fetchedMovieInformation(MovieInfoModel)
        case saveMovieData
        case checkLocalMovieData(String)
        case view(View)
        case binding(BindingAction<State>)
        case alert(PresentationAction<Alert>)
        
        enum Alert: Equatable {}
        
        @CasePathable
        enum View {
            case onAppear
            case onBackButtonTapped
            case onStarTapped(Int)
            case onSaveTapped
            case onEditTapped
            case onDeleteTapped
            case showErrorAlert(NetworkError)
        }
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .fetchedMovieInformation(let movieInformation):
                state.movieInformation = movieInformation
                return .none
            case .saveMovieData:
                let localMovieData = LocalMovieData(
                    movieID: state.movieID ?? "",
                    starRating: state.starRating ?? 0,
                    reviewComment: state.commentText,
                    savedDateString: Date.now.toDateText(),
                    posterPath: state.movieInformation?.posterPath ?? "",
                    title: state.movieInformation?.title ?? ""
                )
                LocalMovieProvider.saveMovie(localMovieData)
                state.isStarRated = true
                return .send(.view(.onAppear))
            case .checkLocalMovieData(let movieID):
                if let movie = LocalMovieProvider.getMovieByID(movieID: movieID) {
                    state.starRating = movie.starRating
                    state.commentText = movie.reviewComment
                    state.commentDate = movie.savedDateString
                    state.isStarRated = true
                }
                return .none
            case .view(.onAppear):
                if let movieID = state.movieID {
                    return .merge([
                        .run { send in
                            await send(fetchMovieInformation(movieID: movieID))
                        },
                        .send(.checkLocalMovieData(movieID))
                    ])
                } else {
                    return .none
                }
            case .view(.onBackButtonTapped):
                return .none
            case .view(.onStarTapped(let starIndex)):
                if starIndex == 0 {
                    if state.starRating == 0 || state.starRating == nil {
                        state.starRating = 1
                    } else {
                        state.starRating = 0
                    }
                } else {
                    state.starRating = starIndex+1
                }
                return .none
            case .view(.onSaveTapped):
                return .send(.saveMovieData)
            case .view(.onEditTapped):
                state.isStarRated.toggle()
                return .none
            case .view(.onDeleteTapped):
                if let movieID = state.movieID {
                    LocalMovieProvider.deleteMovieByID(movieID: movieID)
                }
                return .send(.view(.onBackButtonTapped))
            case .binding:
                return .none
            case .view(.showErrorAlert(let networkError)):
                state.alert = AlertState {
                    TextState("\(networkError.type.errorMessage)")
                }
                return .none
            case .alert:
                state.alert = nil
                return .none
            }
        }
        .ifLet(\.$alert, action: \.alert)
    }
}

private extension DetailFeature {
    func fetchMovieInformation(movieID: String) async -> Action {
        let result: Result<MovieInfoModel, NetworkError> = await movieClient.movieInfo(movieID)
        switch result {
        case .success(let movieInformation):
            return .fetchedMovieInformation(movieInformation)
        case .failure(let networkError):
            return .view(.showErrorAlert(networkError))
        }
    }
}
