//
//  GenricNewFeatureTVC.swift
//  ECommerceProductBrowser
//
//  Created by Arjun Shukla on 23/05/25.
//


import UIKit

class GenricNewFeatureTVC: UITableViewCell {
    
    // MARK: - Iboutlets
    @IBOutlet weak var vWCell: UIView!
    @IBOutlet weak var vWImg: UIView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
