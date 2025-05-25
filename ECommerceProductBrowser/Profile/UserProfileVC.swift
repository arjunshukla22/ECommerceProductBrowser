//
//  UserProfileVC.swift
//  
//
//  Created by Arjun Shukla on 25/05/25.
//

import UIKit
import Foundation

class UserProfileVC: UIViewController {
    
    
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblRole: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setUpUI()
    }
    
    private func setUpUI(){
        
        let retrievedUser : UserProfileResponse? = UserDefaultsManager.shared.loadUser()
        
        // User name
        lblName.text = /retrievedUser?.name
        
        // User role
        lblRole.text = /retrievedUser?.role
        
        // User email
        lblEmail.text = /retrievedUser?.email
        
        // User image
        let placeholderImg = UIImage(named: "user")
        imgUser.sd_setImage(with: URL(string: /retrievedUser?.avatar), placeholderImage: placeholderImg)
        
        self.imgUser.layer.cornerRadius = self.imgUser.frame.size.height/2
        self.imgUser.clipsToBounds = true
        
        self.imgUser.contentMode = .scaleAspectFit
        
        
    }
    
    @IBAction func actionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func actionLogout(_ sender: Any) {
        let alert = UIAlertController(title: "Confirm Logout",
                                      message: "Are you sure you want to log out? \nAll your saved preferences will be cleared.",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Logout", style: .destructive) { _ in
            self.performLogout()
        })
        
        present(alert, animated: true)
        
    }
    
    private func performLogout() {
        
        // Delete token
        TokenManager.shared.deleteToken()
        
        // Clear User preferences
        UserDefaultsManager.shared.clearUser()
        
        // Push Login screen
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let homeVC = storyboard.instantiateViewController(withIdentifier: "LoginVC") as? LoginVC {
            if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                let nav = UINavigationController(rootViewController: homeVC)
                sceneDelegate.window?.rootViewController = nav
            }
        }
        
        
    }
    
}
