//
//  NetworkService.swift
//  ECommerceProductBrowser
//
//  Created by Arjun Shukla on 24/05/25.
//


import Foundation
import Combine


enum NetworkError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case decodingFailed(Error)
    case serverError(Int)
    
    
}

enum ErrorMapper {
    static func message(for error: NetworkError) -> String {
        switch error {
        case .invalidURL: return "Invalid URL."
        case .invalidResponse: return "Invalid server response."
        case .serverError(let code): return "Server error: \(code)"
        case .decodingFailed: return "Failed to decode data."
        case .requestFailed(let err): return "Network error: \(err.localizedDescription)"
        }
    }
}

protocol NetworkServiceProtocol {
    func request<T: Decodable>(_ endpoint: URLRequest) -> AnyPublisher<T, NetworkError>
}


class NetworkService: NetworkServiceProtocol {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T: Decodable>(_ request: URLRequest) -> AnyPublisher<T, NetworkError> {
        return session.dataTaskPublisher(for: request)
            .tryMap { result in
                guard let httpResponse = result.response as? HTTPURLResponse else {
                    throw NetworkError.invalidResponse
                }
                guard (200..<300).contains(httpResponse.statusCode) else {
                    throw NetworkError.serverError(httpResponse.statusCode)
                }
                return result.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                if let networkError = error as? NetworkError {
                    return networkError
                } else if let decodingError = error as? DecodingError {
                    return .decodingFailed(decodingError)
                } else {
                    return .requestFailed(error)
                }
            }
            .eraseToAnyPublisher()
    }
}
