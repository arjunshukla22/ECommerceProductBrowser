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
}


struct LoginResponse: Decodable {
    let access_token: String
    let refresh_token: String
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
}
