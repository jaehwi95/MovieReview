//
//  MovieAPI.swift
//  MovieReview
//
//  Created by Jaehwi Kim on 2/16/25.
//

import Foundation
import ComposableArchitecture

struct MovieClient {
    var nowPlaying: (Int) async -> Result<MoviesModel, NetworkError>
    var popular: (Int) async -> Result<MoviesModel, NetworkError>
    var topRated: (Int) async -> Result<MoviesModel, NetworkError>
    var movieInfo: (String) async -> Result<MovieInfoModel, NetworkError>
}

extension DependencyValues {
    var movieClient: MovieClient {
        get { self[MovieClient.self] }
        set { self[MovieClient.self] = newValue }
    }
}

extension MovieClient: DependencyKey {
    static var liveValue = MovieClient(
        nowPlaying: { page in
            let endpoint: Endpoint = MovieEndpoint.nowPlaying(String(page))
            do {
                let response: NowPlayingResponse = try await NetworkProvider.request(endpoint: endpoint)
                return .success(response.toModel)
            } catch let error as NetworkError {
                return .failure(error)
            } catch {
                return .failure(NetworkError(type: .unknown, path: endpoint.path))
            }
        },
        popular: { page in
            let endpoint: Endpoint = MovieEndpoint.popular(String(page))
            do {
                let response: PopularResponse = try await NetworkProvider.request(endpoint: endpoint)
                return .success(response.toModel)
            } catch let error as NetworkError {
                return .failure(error)
            } catch {
                return .failure(NetworkError(type: .unknown, path: endpoint.path))
            }
        },
        topRated: { page in
            let endpoint: Endpoint = MovieEndpoint.topRated(String(page))
            do {
                let response: TopRatedResponse = try await NetworkProvider.request(endpoint: endpoint)
                return .success(response.toModel)
            } catch let error as NetworkError {
                return .failure(error)
            } catch {
                return .failure(NetworkError(type: .unknown, path: endpoint.path))
            }
        },
        movieInfo: { movieID in
            let endpoint: Endpoint = MovieEndpoint.movieInformation(movieID)
            do {
                let response: MovieInfoResponse = try await NetworkProvider.request(endpoint: endpoint)
                return .success(response.toModel)
            } catch let error as NetworkError {
                return .failure(error)
            } catch {
                return .failure(NetworkError(type: .unknown, path: endpoint.path))
            }
        }
    )
}
