//
//  StoryboardLoader.swift
//  ECommerceProductBrowser
//
//  Created by Arjun Shukla on 26/05/25.
//


import UIKit

enum StoryboardName: String {
    case home = "Home"
    case login = "Login"
    case profile = "Profile"
    case filter = "Filter"
}


struct StoryboardLoader {
    private let storyboard: UIStoryboard

    init(name: StoryboardName) {
        self.storyboard = UIStoryboard(name: name.rawValue, bundle: nil)
    }

    func viewController<T: UIViewController>(ofType type: T.Type) -> T {
        return storyboard.instantiateViewController(withIdentifier: String(describing: T.self)) as! T
    }

    func viewController(withIdentifier identifier: String) -> UIViewController {
        return storyboard.instantiateViewController(withIdentifier: identifier)
    }
}
