//
//  PopularEntity.swift
//  MovieReview
//
//  Created by Jaehwi Kim on 2/18/25.
//

import Foundation

struct PopularResponse: Decodable {
    let page: Int?
    let results: [MovieResult]?
    let totalPages, totalResults: Int?
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

extension PopularResponse {
    var toModel: MoviesModel {
        return .init(
            movieItems: results?.map { movie in
                MovieItem(
                    id: movie.id,
                    backdropPath: movie.backdropPath,
                    posterPath: movie.posterPath,
                    title: movie.title,
                    overview: movie.overview,
                    rate: movie.voteAverage,
                    genres: movie.genreIDs?.compactMap { genreID in
                        Genre(rawValue: genreID)
                    } ?? []
                )
            } ?? []
        )
    }
}
