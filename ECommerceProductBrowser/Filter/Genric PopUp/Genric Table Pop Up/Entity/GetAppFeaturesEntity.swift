//
//  GetAppFeaturesEntity.swift
//  PrepLadder
//
//  Created by Arjun iOS  on 25/06/24.
//  Copyright © 2024 PrepLadder. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Response
struct GetAppFeaturesEntity : Codable {
    var appVersion, title, buttonText: String?
    var featuresList: [FeaturesList]?
}

// MARK: - FeaturesList
struct FeaturesList : Codable {
    var title: String?
    var icon: String?
    var description: String?
    var orderBy: Int?
}
