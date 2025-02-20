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
        var currentTab: Tab = .nowPlaying
        var nowPlayingMovies: [MovieItem] = []
        var popularMovies: [MovieItem] = []
        var topRatedMovies: [MovieItem] = []
        var currentPage: Int = 1
        var isInitial: Bool = true
    }
    
    enum Action: ViewAction {
        case setLoading(Bool)
        case fetchedNowPlayingMovies([MovieItem])
        case fetchedPopularMovies([MovieItem])
        case fetchedTopRatedMovies([MovieItem])
        case view(View)
        
        @CasePathable
        enum View {
            case onAppear
            case selectTab(Tab)
            case onLastMovieViewed
            case onMovieTapped(MovieItem)
        }
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .setLoading(let isLoading):
                // TODO: handle errors
                return .none
            case .fetchedNowPlayingMovies(let nowPlayingMovies):
                state.nowPlayingMovies += nowPlayingMovies
                return .none
            case .fetchedPopularMovies(let popularMovies):
                state.popularMovies += popularMovies
                return .none
            case .fetchedTopRatedMovies(let topRatedMovies):
                state.topRatedMovies += topRatedMovies
                return .none
            case .view(.onAppear):
                if state.isInitial {
                    state.isInitial = false
                    let page = state.currentPage
                    return .merge([
                        .run { send in
                            await send(fetchNowPlayingMovies(page: page))
                        },
                        .run { send in
                            await send(fetchPopularMovies(page: page))
                        },
                        .run { send in
                            await send(fetchTopRatedMovies(page: page))
                        }
                    ])
                } else {
                    return .none
                }
            case .view(.selectTab(let tab)):
                state.currentTab = tab
                return .none
            case .view(.onLastMovieViewed):
                state.currentPage += 1
                let page = state.currentPage
                switch state.currentTab {
                case .nowPlaying:
                    return .run { send in
                        await send(fetchNowPlayingMovies(page: page))
                    }
                case .popular:
                    return .run { send in
                        await send(fetchPopularMovies(page: page))
                    }
                case .topRated:
                    return .run { send in
                        await send(fetchTopRatedMovies(page: page))
                    }
                }
            case .view(.onMovieTapped(let movieItem)):
                // TODO: on movie tapped navigate
                return .none
            }
        }
    }
}

private extension HomeFeature {
    func fetchNowPlayingMovies(page: Int) async -> Action {
        let result: Result<MoviesModel, NetworkError> = await movieClient.nowPlaying(page)
        switch result {
        case .success(let moviesModel):
            return .fetchedNowPlayingMovies(moviesModel.movieItems)
        case .failure:
            return .setLoading(false)
        }
    }
    
    func fetchPopularMovies(page: Int) async -> Action {
        let result: Result<MoviesModel, NetworkError> = await movieClient.popular(page)
        switch result {
        case .success(let moviesModel):
            return .fetchedPopularMovies(moviesModel.movieItems)
        case .failure:
            return .setLoading(false)
        }
    }
    
    func fetchTopRatedMovies(page: Int) async -> Action {
        let result: Result<MoviesModel, NetworkError> = await movieClient.topRated(page)
        switch result {
        case .success(let moviesModel):
            return .fetchedTopRatedMovies(moviesModel.movieItems)
        case .failure:
            return .setLoading(false)
        }
    }
}
