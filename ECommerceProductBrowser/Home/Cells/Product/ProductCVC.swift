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
    @IBOutlet weak var lblCategory: UILabel!
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
    
    
    func bindCellData(product:Product) {
        
        self.lblTitle.text = product.title
        self.lblPrice.text = "\(MsgConst.kSymbolDollar) \(product.price)"
        self.lblCategory.text = product.category.name
        self.lblDescription.text = product.description
        
    
        img.contentMode = .scaleToFill
        img.sd_setImage(with: URL(string: /product.images.first))
        
        let placeholderImg = UIImage(named: "NoImageFound")

        img.sd_setImage(with: URL(string: /product.images.first), placeholderImage: placeholderImg)
        
    }
}
