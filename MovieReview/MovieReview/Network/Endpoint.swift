//
//  Endpoint.swift
//  MovieReview
//
//  Created by Jaehwi Kim on 2/15/25.
//

import Foundation

protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var header: [String: String] { get }
}

enum HTTPMethod: String {
    case GET
}

extension Endpoint {
    var header: [String: String] {
        // TOOD: input accessToken
        let accessToken: String = ""
        
        return [
            "Authorization": "Bearer \(accessToken)"
        ]
    }
    
    var urlRequest: URLRequest {
        get throws {
            guard var url: URL = URL(string: baseURL)?.appending(path: path) else {
                throw NetworkError(type: .invalidURL, path: path)
            }
            
            var urlRequest: URLRequest = URLRequest(url: url)
            urlRequest.httpMethod = method.rawValue
            urlRequest.allHTTPHeaderFields = header
            
            return urlRequest
        }
    }
}
