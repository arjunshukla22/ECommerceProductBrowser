//
//  ProductDetailsVC.swift
//  ECommerceProductBrowser
//
//  Created by Arjun Shukla on 26/05/25.
//

import UIKit

class ProductDetailsVC: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    // MARK: - Variables
    var product : Product?
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setUpUI()
    }
    
    private func setUpUI(){
        
    
        // Product name
        lblProductName.text = /product?.title
        
        // Price Details
        lblPrice.text = "\(MsgConst.kSymbolDollar) \(/product?.price)"
        
        // Category
        lblCategory.text = /product?.category.name
        
        // Description
        lblDescription.text = /product?.description
        
        // User image
        
        let placeholderImg = UIImage(named: "NoImageFound")
        imgProduct.sd_setImage(with: URL(string: /product?.images.first), placeholderImage: placeholderImg)
        imgProduct.contentMode = .scaleToFill
    }
    
    @IBAction func actionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
