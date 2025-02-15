//
//  NetworkProvider.swift
//  MovieReview
//
//  Created by Jaehwi Kim on 2/15/25.
//

import Foundation
import OSLog

protocol NetworkProviderProtocol {
    func request<Response: Decodable>(endpoint: Endpoint) async throws -> Response
}

struct NetworkProvider: NetworkProviderProtocol {
    func request<Response: Decodable>(endpoint: Endpoint) async throws -> Response {
        let data: Data = try await sendRequest(endpoint: endpoint)
        
        do {
            let response: Response = try JSONDecoder().decode(Response.self, from: data)
            return response
        } catch let error as DecodingError {
            let error: NetworkError = NetworkError(type: .decodingError, path: endpoint.path)
            // TODO: log errors
            throw error
        }
    }
}

private extension NetworkProvider {
    func sendRequest(endpoint: Endpoint) async throws -> Data {
        do {
            let path: String = endpoint.path
            let urlRequest: URLRequest = try endpoint.urlRequest
            let urlSession: URLSession = URLSession(configuration: .default)
            
            let (data, urlResponse): (Data, URLResponse) = try await urlSession.data(for: urlRequest)
            
            // TODO: log response string
            
            guard let httpURLResponse: HTTPURLResponse = urlResponse as? HTTPURLResponse else {
                throw NetworkError(type: .notHTTPURLResponse, path: path)
            }
            let statusCode: Int = httpURLResponse.statusCode
            
            switch statusCode {
            case 200...299:
                return data
            case 400...599:
                throw NetworkError(type: .init(statusCode: statusCode), path: path)
            default:
                throw NetworkError(type: .unknown, path: path)
            }
        } catch {
            // TODO: log error
            throw error
        }
    }
}
