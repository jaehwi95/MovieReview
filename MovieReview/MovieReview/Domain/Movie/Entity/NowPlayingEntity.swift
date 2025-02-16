//
//  NowPlayingEntity.swift
//  MovieReview
//
//  Created by Jaehwi Kim on 2/16/25.
//

import Foundation

struct NowPlayingResponse: Decodable {
    let dates: Dates?
    let page: Int?
    let results: [MovieResult]?
    let totalPages, totalResults: Int?
    
    enum CodingKeys: String, CodingKey {
        case dates, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct Dates: Decodable {
    let maximum, minimum: String?
}

struct MovieResult: Decodable {
    let adult: Bool?
    let backdropPath: String?
    let genreIDs: [Int]?
    let id: Int?
    let originalLanguage: String?
    let originalTitle, overview: String?
    let popularity: Double?
    let posterPath, releaseDate, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDs = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

extension NowPlayingResponse {
    var toModel: NowPlayingResult {
        return .init(
            movieItems: results?.map { movie in
                MovieItem(
                    id: movie.id,
                    backdropPath: movie.backdropPath,
                    posterPath: movie.posterPath,
                    title: movie.title
                )
            } ?? []
        )
    }
}
