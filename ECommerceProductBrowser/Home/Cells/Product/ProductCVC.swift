//
//  ProductCVC.swift
//  ECommerceProductBrowser
//
//  Created by Arjun Shukla on 24/05/25.
//

import UIKit

class ProductCVC: UICollectionViewCell {
    
    
    @IBOutlet weak var vWCell: UIView!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var img: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        // Set Up Corner Radius
        vWCell.setBorder(cornerRadius: UIConstants.View.cornerRadius,
                          borderWidth: UIConstants.View.borderWidth,
                          borderColor: ColorUtility.borderColor)
        
        img.layer.cornerRadius = UIConstants.CornerRadius.small
        
        
    }
    
    
    func bindCellData() {
        
        img.contentMode = .scaleToFill
        img.sd_setImage(with: URL(string: "https://images.unsplash.com/3/www.madebyvadim.com.jpg?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8QWNjZXNzb3JpZXN8ZW58MHx8MHx8fDA%3D"))
        
    }
}
