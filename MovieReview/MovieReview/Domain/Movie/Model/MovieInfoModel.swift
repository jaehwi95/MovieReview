//
//  MovieInfoModel.swift
//  MovieReview
//
//  Created by Jaehwi Kim on 2/20/25.
//

import Foundation

struct MovieInfoModel {
    let id: Int?
    let posterPath: String?
    let title: String?
    let rate: Double?
    let genres: [Genre]?
    let overview: String?
    let stars: Int?
    let comment: String?
    
    init(
        id: Int?,
        posterPath: String?,
        title: String?,
        rate: Double?,
        genres: [Genre]?,
        overview: String?,
        stars: Int? = nil,
        comment: String? = nil
    ) {
        self.id = id
        self.posterPath = posterPath
        self.title = title
        self.rate = rate
        self.genres = genres
        self.overview = overview
        self.stars = stars
        self.comment = comment
    }
}
