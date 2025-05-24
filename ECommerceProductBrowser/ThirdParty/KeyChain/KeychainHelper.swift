//
//  KeychainHelper.swift
//  ECommerceProductBrowser
//
//  Created by Arjun Shukla on 24/05/25.
//

import Foundation
import Security

class KeychainHelper {
    static let shared = KeychainHelper()
    private init() {}

    func save<T: Codable>(_ item: T, service: String, account: String) {
        do {
            let data = try JSONEncoder().encode(item)
            let query: [String: Any] = [
                kSecClass as String       : kSecClassGenericPassword,
                kSecAttrService as String : service,
                kSecAttrAccount as String : account,
                kSecValueData as String   : data
            ]

            SecItemDelete(query as CFDictionary)
            SecItemAdd(query as CFDictionary, nil)
        } catch {
            print("❌ Failed to encode item for keychain: \(error)")
        }
    }

    func read<T: Codable>(_ type: T.Type, service: String, account: String) -> T? {
        let query: [String: Any] = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrService as String : service,
            kSecAttrAccount as String : account,
            kSecReturnData as String  : true,
            kSecMatchLimit as String  : kSecMatchLimitOne
        ]

        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)

        guard status == errSecSuccess, let data = result as? Data else { return nil }

        do {
            let item = try JSONDecoder().decode(T.self, from: data)
            return item
        } catch {
            print("❌ Failed to decode item from keychain: \(error)")
            return nil
        }
    }

    func delete(service: String, account: String) {
        let query: [String: Any] = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrService as String : service,
            kSecAttrAccount as String : account
        ]
        SecItemDelete(query as CFDictionary)
    }
}
