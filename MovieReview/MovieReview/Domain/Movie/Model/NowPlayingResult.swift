//
//  NowPlayingResult.swift
//  MovieReview
//
//  Created by Jaehwi Kim on 2/16/25.
//

import Foundation

struct NowPlayingResult {
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
}
