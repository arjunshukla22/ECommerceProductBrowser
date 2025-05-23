//
//  UiView + Ext.swift
//  ECommerceProductBrowser
//
//  Created by Arjun Shukla on 23/05/25.
//

import Foundation
import UIKit


import UIKit

extension UIView {
    func setBorder(cornerRadius: CGFloat, borderWidth: CGFloat, borderColor: UIColor) {
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        self.layer.masksToBounds = true
    }
}

