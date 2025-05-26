//
//  UserDefaultsManager.swift
//  ECommerceProductBrowser
//
//  Created by Arjun Shukla on 24/05/25.
//

import UIKit
import Foundation

struct UserDefaultsKeys {
    static let savedUser = "savedUser"
}


class UserDefaultsManager {
    
    static let shared = UserDefaultsManager()
    private let defaults = UserDefaults.standard

    func saveUser(_ user: UserProfileResponse) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(user) {
            defaults.set(encoded, forKey: UserDefaultsKeys.savedUser)
        }
    }

    func loadUser() -> UserProfileResponse? {
        guard let data = defaults.data(forKey: UserDefaultsKeys.savedUser) else { return nil }
        return try? JSONDecoder().decode(UserProfileResponse.self, from: data)
    }

    func clearUser() {
        defaults.removeObject(forKey: UserDefaultsKeys.savedUser)
    }
}
