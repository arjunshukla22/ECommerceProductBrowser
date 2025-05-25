//
//  GenricTablePopup.swift
//  PrepLadder
//
//  Created by Arjun iOS  on 24/06/24.
//  Copyright © 2024 PrepLadder. All rights reserved.
//

import UIKit

struct MsgConst {
    static var kCircleText = " • "
    static var kSymbolIndianRupee = "₹"
    static var kSymbolDollar = "$"
    
    static var SCREEN_WIDTH = UIScreen.main.bounds.size.width
    static var SCREEN_HEIGHT = UIScreen.main.bounds.size.height
    static var IS_IPAD = UIDevice.current.userInterfaceIdiom == .pad
    static var IS_IPHONE  = UIDevice.current.userInterfaceIdiom == .phone

}

class GenricTablePopup: UIView {
    

    @IBOutlet weak var vwBase: UIView!
    @IBOutlet weak var vwDrop: UIView!
    @IBOutlet weak var vwPopup: UIView!
    
    @IBOutlet weak var tbl: UITableView!
    
    @IBOutlet weak var tblHeight: NSLayoutConstraint!
    
    @objc var outerTapHidden = true
    
    var arrData : [Category] = []
    
    var selectedCategory : Category?
   
    //Call Back
    var callBackForSelect : ((Category) -> Void)?
    
    public override func awakeFromNib() {
        self.initialSetUp()
        
       // vwPopup.layer.cornerRadius = MsgConst.IS_IPAD ? 8 : 0
        vwDrop.isHidden =  false
        
        if #available(iOS 15.0, *){
            self.tbl.sectionHeaderTopPadding = 0
        }
        
        self.tbl.register(UINib(nibName: "GenricNewFeatureTVC", bundle: nil), forCellReuseIdentifier: "GenricNewFeatureTVC")
        
        self.tbl.register(UINib(nibName: "GenricNewFeatureHeaderTVC", bundle: nil), forCellReuseIdentifier: "GenricNewFeatureHeaderTVC")
        
        // Hide scroll indicators
        self.tbl.showsVerticalScrollIndicator = false
        self.tbl.showsHorizontalScrollIndicator = false
    }
    
    func initialSetUp(){
        
        if outerTapHidden {
            self.addTapGesture()
        }
    }
    
    func SetContentData(data:[Category])   {
       
        self.arrData = data
        
      
       DispatchQueue.main.async {
           
           self.tbl.reloadData()
           
           self.tbl.layoutIfNeeded()
                      
           let contentHeight = self.tbl.contentSize.height
           
           if (contentHeight > (MsgConst.SCREEN_HEIGHT * 0.7)){
               self.tblHeight.constant = MsgConst.SCREEN_HEIGHT * 0.7;
           }
           else{
               self.tblHeight.constant = contentHeight;
           }
           
          // print("contentHeight :- \(contentHeight) <======> \(MsgConst.SCREEN_HEIGHT * 0.7)")
           
       }
    }
}

//MARK: GESTURES
extension GenricTablePopup {
    
    func addTapGesture() {
        vwBase.addTapGesture { _ in
            self.dismissAndRemove()
        }
        vwDrop.addTapGesture { _ in
            self.dismissAndRemove()
        }
    }
    
    func dismissAndRemove(isCancel:Bool = true){
        
        //Hide With Animation
        DragAndDropMethods.hideView(withAnimation: self, heightOfView: self.vwPopup.frame.size.height, popUpview: self.vwPopup)
        
        //Remove From SuperView
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            self.removeFromSuperview()
        }
    }
}

//MARK: ACTIONS

extension GenricTablePopup :UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return /self.arrData.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GenricNewFeatureHeaderTVC") as? GenricNewFeatureHeaderTVC else {
            return UITableViewCell() }
        
        cell.lblTitle.text = "Select Category"
        return cell.contentView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GenricNewFeatureTVC") as? GenricNewFeatureTVC else {
            return UITableViewCell() }
        cell.selectionStyle = .none
        
        let cellDic : Category  = self.arrData[indexPath.row]
        cell.lblTitle.text = cellDic.name
        
        cell.vWCell.backgroundColor = self.selectedCategory?.name == cellDic.name ? ColorUtility.selectedCell_bgColor : ColorUtility.clr_white
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        let cellDic : Category  = self.arrData[indexPath.row]
        
        self.selectedCategory = cellDic
        
        self.tbl.reloadData()
        
        callBackForSelect?(cellDic)
        
        self.dismissAndRemove()
        
    }
}
