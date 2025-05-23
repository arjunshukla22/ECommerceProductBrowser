//
//  UIConstants.swift
//  ECommerceProductBrowser
//
//  Created by Arjun Shukla on 23/05/25.
//


import UIKit

enum UIConstants {
    
    enum Padding {
        static let small: CGFloat = 8.0
        static let medium: CGFloat = 16.0
        static let large: CGFloat = 24.0
    }
    
    enum CornerRadius {
        static let small: CGFloat = 4.0
        static let medium: CGFloat = 8.0
        static let large: CGFloat = 12.0
        static let button: CGFloat = 10.0
        static let view: CGFloat = 12.0
    }
    
    enum BorderWidth {
        static let small: CGFloat = 1.0
        static let medium: CGFloat = 2.0
        static let large: CGFloat = 4.0
    }
    
    enum Button {
        static let height: CGFloat = 44.0
        static let cornerRadius: CGFloat = CornerRadius.button
        static let horizontalPadding: CGFloat = Padding.medium
    }
    
    enum View {
        static let cornerRadius: CGFloat = CornerRadius.view
        static let borderWidth: CGFloat = BorderWidth.small
        static let padding: CGFloat = Padding.medium
    }
}
