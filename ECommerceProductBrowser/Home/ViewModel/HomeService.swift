//
//  LoginService.swift
//  ECommerceProductBrowser
//
//  Created by Arjun Shukla on 24/05/25.
//

import Foundation
import Combine
import Alamofire



protocol HomeServiceProtocol {
    func fetchCategories() -> AnyPublisher<[Category], NetworkError>
    func fetchProducts(for categoryId: String) -> AnyPublisher<[Product], NetworkError>
}

class HomeService: HomeServiceProtocol {
    private let networkManager: AlamofireNetworkManagerProtocol

    init(networkManager: AlamofireNetworkManagerProtocol = AlamofireNetworkManager()) {
        self.networkManager = networkManager
    }

    func fetchCategories() -> AnyPublisher<[Category], NetworkError> {
        return networkManager.request(APIConstants.Categories.category,
                                      method: .get,
                                      parameters: nil,
                                      encoding: URLEncoding.default,
                                      headers: nil)
    }

    func fetchProducts(for categoryId: String) -> AnyPublisher<[Product], NetworkError> {
        return networkManager.request(APIConstants.Products.product,
                                      method: .get,
                                      parameters: nil,
                                      encoding: URLEncoding.default,
                                      headers: nil)
    }
}



protocol AlamofireNetworkManagerProtocol {
    func request<T: Decodable>(_ url: URLConvertible,
                                method: HTTPMethod,
                                parameters: Parameters?,
                                encoding: ParameterEncoding,
                                headers: HTTPHeaders?) -> AnyPublisher<T, NetworkError>
}


class AlamofireNetworkManager: AlamofireNetworkManagerProtocol {
    
    func request<T: Decodable>(_ url: URLConvertible,
                                method: HTTPMethod = .get,
                                parameters: Parameters? = nil,
                                encoding: ParameterEncoding = URLEncoding.default,
                                headers: HTTPHeaders? = nil) -> AnyPublisher<T, NetworkError> {
        
        return Future<T, NetworkError> { promise in
            AF.request(url,
                       method: method,
                       parameters: parameters,
                       encoding: encoding,
                       headers: headers)
                .validate()
                .responseDecodable(of: T.self) { response in
                    switch response.result {
                    case .success(let value):
                        promise(.success(value))
                    case .failure(let error):
                        let statusCode = response.response?.statusCode
                        if let code = statusCode {
                            promise(.failure(.serverError(code)))
                        } else {
                            promise(.failure(.requestFailed(error)))
                        }
                    }
                }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}
