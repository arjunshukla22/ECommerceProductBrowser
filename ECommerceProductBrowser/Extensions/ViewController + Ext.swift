//
//  ViewController + Ext.swift
//  ECommerceProductBrowser
//
//  Created by Arjun Shukla on 23/05/25.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(title: String, message: String, okTitle: String = "Okay", handler: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: okTitle, style: .default) { _ in
            handler?()
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}

extension UIViewController {
    
    func ShowShimmerOrNot(isShow:Bool, vWMain:UIView, vWInner:UIView) {
        if isShow == false {
            vWInner.stopShimmeringAnimation()
            vWInner.isHidden = true
            vWMain.isHidden = true
            
        }else{
            //            vWInner.layoutIfNeeded()
            //            vWInner.layoutSubviews()
            vWInner.startShimmeringAnimation(direction: .leftToRight)
            vWInner.isHidden = false
            vWMain.isHidden = false
        }
    }
    
}
