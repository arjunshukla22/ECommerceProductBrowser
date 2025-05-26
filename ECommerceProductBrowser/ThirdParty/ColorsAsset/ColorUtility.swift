//
//  ColorUtility.swift
//  ECommerceProductBrowser
//
//  Created by Arjun Shukla on 23/05/25.
//


import Foundation
import UIKit

class ColorUtility: NSObject {
    
    // Enum to define the color names
    enum ColorName: String {
        
        case primary                    = "primaryColor"              //#303153 (48, 49, 83)
        case secondary                  = "secondaryColor"            //#8E8DA8 (142, 141, 168)
        case border                     = "borderColor"               //#E9EEF2 (233, 238, 242)
        case background                 = "clr_bgColor"               //#F7F7F7 (247, 247, 247)
        case clr_white                  = "clr_white"                 //#FFFFFF
        case errorRed_clr               = "errorRed_clr"              //#E4212D (228, 33, 45)
        case selectedCell_bgColor       = "selectedCell_bgColor"      //#ECF9FF (236, 249, 255)
        case shimmer_clr                = "shimmer_clr"               //#E0E0E0 (224, 224, 224)
        
        var name: String { return self.rawValue }
    }
    
    @objc static var primaryColor: UIColor {
        return color(named: .primary)
    }
    
    @objc static var secondaryColor: UIColor {
        return color(named: .secondary)
    }
    @objc static var borderColor: UIColor {
        return color(named: .border)
    }
    
    @objc static var clr_bgColor: UIColor {
        return color(named: .background)
    }
    
    @objc static var clr_white: UIColor {
        return color(named: .clr_white)
    }

    @objc static var errorRed_clr: UIColor {
        return color(named: .errorRed_clr)
    }
    
    @objc static var selectedCell_bgColor: UIColor {
        return color(named: .selectedCell_bgColor)
    }
    
    @objc static var shimmer_clr: UIColor {
        return color(named: .shimmer_clr)
    }

    // Example of a common helper method for generating colors
    @objc static func colorWithAlpha(_ color: UIColor, alpha: CGFloat) -> UIColor {
        return color.withAlphaComponent(alpha)
    }
    
    // Retrieve a color from the asset catalog by name
    static func color(named name: ColorName) -> UIColor {
        let colorName = name.name
        
        guard let color = UIColor(named: colorName) else {
            debugPrint("Warning: Color named \(colorName) not found. Returning .clear.")
            return UIColor.clear
        }
        
        return color
    }
    
    @objc static func getHexColorString(_ color: UIColor) -> String {
        return hexStringFromColor(color: color)
    }
    
    static func hexStringFromColor(color: UIColor) -> String {
        let components = color.cgColor.components
        let r: CGFloat = components?[0] ?? 0.0
        let g: CGFloat = components?[1] ?? 0.0
        let b: CGFloat = components?[2] ?? 0.0
        
        let hexString = String.init(format: "#%02lX%02lX%02lX", lroundf(Float(r * 255)), lroundf(Float(g * 255)), lroundf(Float(b * 255)))
        return hexString
    }
}



