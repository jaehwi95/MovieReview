//
//  MoviesModel.swift
//  MovieReview
//
//  Created by Jaehwi Kim on 2/16/25.
//

import Foundation

struct MoviesModel {
    let movieItems: [MovieItem]
    
    init(movieItems: [MovieItem]) {
        self.movieItems = movieItems
    }
}

struct MovieItem {
    let id: Int?
    let backdropPath: String?
    let posterPath: String?
    let title: String?
    let overview: String?
    let rate: Double?
    let genres: [Genre]?
}
