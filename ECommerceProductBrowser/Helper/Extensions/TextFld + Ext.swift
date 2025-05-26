//
//  TextFld + Ext.swift
//  ECommerceProductBrowser
//
//  Created by Arjun Shukla on 26/05/25.
//

import UIKit
import Combine
import Foundation

extension UITextField {
    var textPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: self)
            .compactMap { ($0.object as? UITextField)?.text }
            .eraseToAnyPublisher()
    }
}
