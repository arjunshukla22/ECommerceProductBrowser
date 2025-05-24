//
//  TokenManager.swift
//  ECommerceProductBrowser
//
//  Created by Arjun Shukla on 24/05/25.
//

import UIKit
import Foundation

struct Token: Codable {
    let accessToken: String
    let refreshToken: String
}


class TokenManager {
    static let shared = TokenManager()
    
    private let service = "com.ArjunShukla.auth"
    private let account = "user_token"

    func save(token: Token) {
        KeychainHelper.shared.save(token, service: service, account: account)
    }

    func getToken() -> Token? {
        return KeychainHelper.shared.read(Token.self, service: service, account: account)
    }

    func deleteToken() {
        KeychainHelper.shared.delete(service: service, account: account)
    }
}
