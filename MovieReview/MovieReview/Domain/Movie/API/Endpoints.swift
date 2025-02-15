//
//  Endpoints.swift
//  MovieReview
//
//  Created by Jaehwi Kim on 2/15/25.
//

import Foundation

enum MovieEndpoint: Endpoint {
    case nowPlaying
    case popular
    case topRated
    case movieInformation(String)
    case movieImage(String)
}

extension MovieEndpoint {
    var baseURL: String {
        switch self {
        case .nowPlaying: Constant.baseURL
        case .popular: Constant.baseURL
        case .topRated: Constant.baseURL
        case .movieInformation: Constant.baseURL
        case .movieImage: Constant.imageURL
        }
    }
    
    var path: String {
        switch self {
        case .nowPlaying:
            return "/now_playing"
        case .popular:
            return "/popular"
        case .topRated:
            return "/top_rated"
        case .movieInformation(let movieID):
            return "/\(movieID)"
        case .movieImage(let imagePath):
            return "\(imagePath)"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .nowPlaying: .GET
        case .popular: .GET
        case .topRated: .GET
        case .movieInformation: .GET
        case .movieImage: .GET
        }
    }
}
