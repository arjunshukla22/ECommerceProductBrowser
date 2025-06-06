//
//  OptionalType.swift
//  ECommerceProductBrowser
//
//  Created by Arjun Shukla on 23/05/25.
//


import Foundation
import UIKit

//MARK:- PROTOCOL
protocol OptionalType { init() }

//MARK:- EXTENSIONS
extension Dictionary: OptionalType {}
extension UIImage: OptionalType {}
extension IndexPath: OptionalType {}
extension UIFont: OptionalType {}
extension UIView: OptionalType {}
extension UIViewController: OptionalType {}
extension String: OptionalType {}
extension Bool: OptionalType {}
extension Int: OptionalType {}
extension Int64: OptionalType { }
extension Float: OptionalType {}
extension Double: OptionalType {}
extension CGFloat: OptionalType {}
extension CGRect: OptionalType {}
extension Date : OptionalType{}
extension Data : OptionalType{}
extension NSData : OptionalType{}
extension CGPoint : OptionalType{}


prefix operator /

//unwrapping values
prefix func /<T:OptionalType>(value:T?) -> T {
    guard let validValue = value else { return T() }
    return validValue
}
