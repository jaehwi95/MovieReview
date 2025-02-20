//
//  NetworkError.swift
//  MovieReview
//
//  Created by Jaehwi Kim on 2/15/25.
//

import Foundation

struct NetworkError: Error {
    let type: NetworkErrorType
    let path: String
}

enum NetworkErrorType {
    case badRequest
    case unAuthorized
    case forbidden
    case notFound
    case methodNotAllowed
    case notAcceptable
    case unprocessableContent
    case tooManyRequests
    case clientError
    
    case internalServerError
    case notImplemented
    case badGateway
    case serviceUnavailable
    case gatewayTimeout
    case serverError
    
    case decodingError
    case notHTTPURLResponse
    case invalidURL
    case unknown
    
    init(statusCode: Int) {
        switch statusCode {
        case 400:
            self = .badRequest
        case 401:
            self = .unAuthorized
        case 403:
            self = .forbidden
        case 404:
            self = .notFound
        case 405:
            self = .methodNotAllowed
        case 406:
            self = .notAcceptable
        case 422:
            self = .unprocessableContent
        case 429:
            self = .tooManyRequests
        case 400...499:
            self = .clientError
        case 500:
            self = .internalServerError
        case 501:
            self = .notImplemented
        case 502:
            self = .badGateway
        case 503:
            self = .serviceUnavailable
        case 504:
            self = .gatewayTimeout
        case 500...599:
            self = .serverError
        default:
            self = .unknown
        }
    }
    
    var errorMessage: String {
        switch self {
        case .badRequest:
            return "Bad Request"
        case .unAuthorized:
            return "Unauthorized"
        case .forbidden:
            return "Forbidden"
        case .notFound:
            return "Not Found"
        case .methodNotAllowed:
            return "Method Not Allowed"
        case .notAcceptable:
            return "Not Acceptable"
        case .unprocessableContent:
            return "Unprocessable Content"
        case .tooManyRequests:
            return "Too Many Requests"
        case .clientError:
            return "Client Error"
        case .internalServerError:
            return "Internal Server Error"
        case .notImplemented:
            return "Not Implemented"
        case .badGateway:
            return "Bad Gateway"
        case .serviceUnavailable:
            return "Service Unavailable"
        case .gatewayTimeout:
            return "Gateway Timeout"
        case .serverError:
            return "Server Error"
        case .decodingError:
            return "Decoding Error"
        case .notHTTPURLResponse:
            return "Not HTTPURLResponse"
        case .invalidURL:
            return "Invalid URL"
        case .unknown:
            return "Unknown Error"
        }
    }
}
