//
//  StringExtension.swift
//  PrepLadder
//
//  Created by Arjun iOS  on 28/11/22.
//  Copyright © 2022 PrepLadder. All rights reserved.
//

import Foundation
import UIKit



extension String {
    func titleCase() -> String {
            return self
                .replacingOccurrences(of: "([A-Z])",
                                      with: "$1",
                                      options: .regularExpression,
                                      range: range(of: self))
                .trimmingCharacters(in: .whitespacesAndNewlines)
                .capitalized // If input is in llamaCase
        }
}
