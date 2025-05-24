//
//  ApiConstant.swift
//  ECommerceProductBrowser
//
//  Created by Arjun Shukla on 24/05/25.
//

import Foundation

struct APIConstants {
    
    // MARK: - Base URL
    private static let baseURL = "https://api.escuelajs.co/api/v1/"
    
    // MARK: - Endpoints
    struct Auth {
        static let login = baseURL + "auth/login"
        static let profile = baseURL + "auth/profile"
    }
    
    struct Categories {
        static let category = baseURL + "categories"
    }
    struct Products {
        static let product = baseURL + "products"
        
        
    }
}

