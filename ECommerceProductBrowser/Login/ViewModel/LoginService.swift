//
//  LoginService.swift
//  ECommerceProductBrowser
//
//  Created by Arjun Shukla on 24/05/25.
//

import Foundation
import UIKit
import Combine

protocol LoginServiceProtocol {
    func login(email: String, password: String) -> AnyPublisher<LoginResponse, NetworkError>
    func fetchProfile(token:String) -> AnyPublisher<UserProfileResponse, NetworkError>
}


struct LoginResponse: Decodable {
    let access_token: String
    let refresh_token: String
}

struct UserProfileResponse: Codable {
    let id: Int
    let email, password, name, role: String
    let avatar: String
    let creationAt, updatedAt: String
}




class LoginService: LoginServiceProtocol {
    
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    func login(email: String, password: String) -> AnyPublisher<LoginResponse, NetworkError> {
        guard let url = URL(string: APIConstants.Auth.login) else {
            return Fail(error: .invalidURL).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: String] = ["email": email, "password": password]
        request.httpBody = try? JSONEncoder().encode(body)
        
        return networkService.request(request)
    }
    
    func fetchProfile(token:String) -> AnyPublisher<UserProfileResponse, NetworkError> {
        guard let url = URL(string: APIConstants.Auth.profile) else {
            return Fail(error: .invalidURL).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Add Bearer Token
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        return networkService.request(request)
    }
}
