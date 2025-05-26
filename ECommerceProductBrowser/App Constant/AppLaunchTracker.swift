//
//  AppLaunchTracker.swift
//  ECommerceProductBrowser
//
//  Created by Arjun Shukla on 26/05/25.
//


final class AppLaunchTracker {

    private let hasLaunchedBeforeKey = "hasLaunchedBefore"

    static let shared = AppLaunchTracker()

    private init() {}

    /// Returns true if this is the first launch after install
    func isFirstLaunch() -> Bool {
        let hasLaunchedBefore = UserDefaults.standard.bool(forKey: hasLaunchedBeforeKey)
        if !hasLaunchedBefore {
            UserDefaults.standard.set(true, forKey: hasLaunchedBeforeKey)
            UserDefaults.standard.synchronize()
            return true
        }
        return false
    }
    
    func reset() {
        UserDefaults.standard.removeObject(forKey: hasLaunchedBeforeKey)
        UserDefaults.standard.synchronize()
    }
}
