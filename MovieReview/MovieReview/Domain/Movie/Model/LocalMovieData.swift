//
//  LocalMovieData.swift
//  MovieReview
//
//  Created by Jaehwi Kim on 2/21/25.
//

import Foundation

struct LocalMovieData: Codable, Equatable {
    let movieID: String
    var starRating: Int
    var reviewComment: String
    var savedDateString: String
}
