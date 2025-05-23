//
//  LoginVC.swift
//  ECommerceProductBrowser
//
//  Created by Arjun Shukla on 23/05/25.
//

import UIKit

class LoginVC: UIViewController {
    
    // IB Outlets
    @IBOutlet weak var vWEmail: UIView!
    @IBOutlet weak var vWPassword: UIView!

    @IBOutlet weak var lblErrorEmail: UILabel!
    @IBOutlet weak var lblErrorPassword: UILabel!
    
    
    @IBOutlet weak var btnLogin: UIButton!
    
    @IBOutlet weak var btnShowHideSecurePasword: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.setUpUI()
    }
    
    
    private func setUpUI(){
        // Set Up Corner Radius
        
        
        
    }
    
    @IBAction func actionShowHideSecurePassword(_ sender: Any) {
        
    }
    
    @IBAction func actionLoginTapped(_ sender: Any) {
        
    }
    
}

