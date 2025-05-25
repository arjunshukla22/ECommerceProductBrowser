//
//  GenricBottomPopUp.swift
//  PrepLadder
//
//  Created by Arjun iOS  on 20/06/24.
//  Copyright © 2024 PrepLadder. All rights reserved.
//

import UIKit

class GenricBottomPopUp: UIView {
    
    @IBOutlet weak var vwBase: UIView!
    @IBOutlet weak var vwDrop: UIView!
    @IBOutlet weak var vwPopup: UIView!
    
    @IBOutlet weak var lbltitle: UILabel!
    @IBOutlet weak var lblSubtitle: UILabel!
    
    @IBOutlet weak var vWImg: UIView!
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnOkay: UIButton!
    
    @IBOutlet weak var vwCheck: UIView!
    @IBOutlet weak var imgCheckbox: UIImageView!
    
    
    @IBOutlet weak var lblCheckBox: UILabel!
    
    @IBOutlet weak var btnCheckBox: UIButton!
    
    var dataDict:NSDictionary?
    
    var functionName:String = ""
    var secfunctionName:String = ""
    
    var isChecked = false

    
        
    //Call Back
    @objc var callBackForSelect : ((NSDictionary? , String) -> Void)?

    public override func awakeFromNib() {
        self.initialSetUp()
        
        vwPopup.layer.cornerRadius = MsgConst.IS_IPAD ? 8 : 0
        vwDrop.isHidden = MsgConst.IS_IPAD ? true : false
        
        btnCancel.layer.cornerRadius = 8;
        btnCancel.layer.borderColor =  ColorUtility.borderColor.cgColor;
        btnCancel.layer.borderWidth = 1;
    }
    
    func initialSetUp(){
    }
}

//MARK: GESTURES
extension GenricBottomPopUp {
    
    @objc func allowGesture(){
        self.addTapGesture()
    }
    
    @objc func setUpData(dict: NSDictionary){
                
    }
}

//MARK: ACTIONS
extension GenricBottomPopUp {
    
    @IBAction func okayBtnAction(_ sender: UIButton) {
        
        self.checkDismiss(function: self.functionName)
        self.callBackForSelect?(dataDict, "okay")
    }
    
    @IBAction func cancelBtnAction(_ sender: UIButton) {
        
        self.checkDismiss(function: self.secfunctionName)
        self.callBackForSelect?(dataDict, "Cancel")
    }
    
    func checkDismiss(function:String)
    {
        if function != "openDial" && function != "openEmail"
        {
            self.dismissAndRemove()
        }
    }
    
    @IBAction func checkBtnAction(_ sender: UIButton) {
        
        isChecked = !isChecked
        
        if isChecked
        {
            self.btnOkay.isUserInteractionEnabled = true
            self.imgCheckbox.image = UIImage(named: "checkBoxAppBG")
            self.btnOkay.backgroundColor = ColorUtility.primaryColor
            self.btnOkay.titleLabel?.textColor = .white

        }
        else
        {
            self.btnOkay.isUserInteractionEnabled = false
            self.imgCheckbox.image = UIImage(named: "uncheckBox")
            self.btnOkay.titleLabel?.textColor = ColorUtility.secondaryColor
            self.btnOkay.backgroundColor = ColorUtility.borderColor;
        }
    }
}

//MARK: GESTURES
extension GenricBottomPopUp {
    
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
