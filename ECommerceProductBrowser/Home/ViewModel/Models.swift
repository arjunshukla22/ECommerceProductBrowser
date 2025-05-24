//
//  Models.swift
//  ECommerceProductBrowser
//
//  Created by Arjun Shukla on 24/05/25.
//

import Foundation
import UIKit


struct Category: Decodable, Identifiable {
    let id: Int
    let name, slug: String
    let image: String
    let creationAt, updatedAt: String
}

struct Product: Decodable, Identifiable {
    let id: Int
    let title, slug: String
    let price: Int
    let description: String
    let category: Category
    let images: [String]
    let creationAt, updatedAt: String
}

