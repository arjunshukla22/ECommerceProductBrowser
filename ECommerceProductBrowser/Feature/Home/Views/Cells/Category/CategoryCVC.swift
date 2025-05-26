//
//  CategoryCVC.swift
//  ECommerceProductBrowser
//
//  Created by Arjun Shukla on 24/05/25.
//

import UIKit
import SDWebImage

class CategoryCVC: UICollectionViewCell {
    
    // MARK: - IbOutlets
    @IBOutlet weak var vWCell: UIView!
    @IBOutlet weak var lblTitle: UILabel!
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
    
    // MARK: - Bind Data 
    func bindCellData(category:Category) {
        
        self.lblTitle.text = category.name
        
        img.contentMode = .scaleToFill
        
        let placeholderImg = UIImage(named: "NoImageFound")
        img.sd_setImage(with: URL(string: category.image), placeholderImage: placeholderImg)
    }

}
