//
//  LocalMovieData.swift
//  MovieReview
//
//  Created by Jaehwi Kim on 2/21/25.
//

import Foundation

struct LocalMovieData: Codable, Equatable, Hashable {
    let movieID: String
    let starRating: Int
    let reviewComment: String
    let savedDateString: String
    let posterPath: String
    let title: String
}
