//
//  MovieAPI.swift
//  MovieReview
//
//  Created by Jaehwi Kim on 2/16/25.
//

import Foundation
import ComposableArchitecture

struct MovieClient {
    var nowPlaying: () async -> Result<NowPlayingResult, NetworkError>
}

extension DependencyValues {
    var movieClient: MovieClient {
        get { self[MovieClient.self] }
        set { self[MovieClient.self] = newValue }
    }
}

extension MovieClient: DependencyKey {
    static var liveValue = MovieClient(
        nowPlaying: {
            let endpoint: Endpoint = MovieEndpoint.nowPlaying
            do {
                let response: NowPlayingResponse = try await NetworkProvider.request(endpoint: endpoint)
                return .success(response.toModel)
            } catch let error as NetworkError {
                return .failure(error)
            } catch {
                return .failure(NetworkError(type: .unknown, path: endpoint.path))
            }
        }
    )
}
