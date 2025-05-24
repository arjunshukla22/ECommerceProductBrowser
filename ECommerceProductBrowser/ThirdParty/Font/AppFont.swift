//
//  AppFont.swift
//  ECommerceProductBrowser
//
//  Created by Arjun Shukla on 23/05/25.
//

import UIKit
import Foundation

enum AppFont{
    
    case regular
    case semibold
    case bold
    case blackItalic
    case semibolditalic
    
    func font(size:CGFloat) -> UIFont{
        
        let defaultFont = UIFont.systemFont(ofSize: size, weight: .regular)
        
        if self == .regular{
            return UIFont(name: "avertastd-regular", size: size) ?? defaultFont
        }else if self == .semibold{
            return UIFont(name: "avertastd-semibold", size: size) ?? defaultFont
        }else if self == .bold{
            return UIFont(name: "avertastd-bold", size: size) ?? defaultFont
        }
        else if self == .blackItalic{
            return UIFont(name: "avertastd-blackitalic", size: size) ?? defaultFont
        }
        else if self == .semibolditalic{
            return UIFont(name: "avertastd-semibolditalic", size: size) ?? defaultFont
        }
        return defaultFont
    }
}
