//
//  ColorUtility.swift
//  ECommerceProductBrowser
//
//  Created by Arjun Shukla on 23/05/25.
//


import Foundation
import UIKit

class ColorUtility: NSObject {
    
    // Enum to define the color names
    enum ColorName: String {
        case primary                    = "primaryColor"              //#303153 (48, 49, 83)
        case secondary                  = "secondaryColor"            //#8E8DA8 (142, 141, 168)
        case shimmer_clr                = "shimmer_clr"               //#E0E0E0 (224, 224, 224)
        case primaryMidnightBlue        = "primaryMidnightBlue"       //#131227 (19, 18, 39)

        case border                     = "borderColor"               //#E9EEF2 (233, 238, 242)
        case borderDarkColor            = "borderDarkColor"           //#D6D6D6 (214, 214, 214)

        case background                 = "clr_bgColor"               //#F7F7F7 (247, 247, 247)
        case selectedCell_bgColor       = "selectedCell_bgColor"      //#ECF9FF (236, 249, 255)
        case separator                  = "separatorColor"            //#F7F9FB (247, 249, 251)
        case onBordingClr               = "onBordingClr"              //#E5F0FF (229, 240, 255)
        case clr_disable                = "clr_disable"               //#A2A0A2 (162, 160, 162)
        case clr_disable_text           = "clr_disable_text"          //#94CEEB (148, 206, 235)

        case appColor                   = "AppColor"                  //#00A3FF (0, 163, 255)
        case skyBlueColor               = "skyBlueColor"              //#11BBE6 (17, 187, 230)
        case clr_timerBlue              = "clr_timerBlue"             //#0C50B1 (12, 80, 177)
        case dotBlueColor               = "dotBlueColor"              //#2D81F7 (45, 129, 247)
        case lightBlueColor             = "lightBlueColor"            //#BCE7FF (188, 231, 255)
        case quizBlueColor              = "quizBlueColor"             //#1C2939 (28, 41, 57);
        case clr_secondry_blue          = "clr_secondry_blue"         //#E0EBFF (224, 235, 255, 1)
        
        case clr_brown_light            = "clr_brown_light"           //#B17909 (177, 121, 9)

        case clr_red_dark               = "clr_red"                   //#D14650 (209, 70, 80)
        case clr_red_light              = "clr_red_light"             //#DA6B73 (218, 107, 115)
        case errorRed_clr               = "errorRed_clr"              //#E4212D (228, 33, 45)
        
        case clr_green                  = "clr_green"                 //#008800 (0, 136, 0)
        case clr_green_light            = "clr_green_light"           //#08BD80 (8, 189, 128)
        case clr_StrongGreen            = "clr_StrongGreen"           //#31DFBB (49, 223, 187)
        case clr_prepCompGreen          = "clr_prepCompGreen"           //#2ADDA1 (42, 221, 161)
        case quiz_green                 = "quiz_green"                 //#2ADDA1 (42, 221, 161)
        
        case blackColor                 = "blackColor"                //#000000
        case shadow_Color               = "shadow_Color"              //#000000, 60% opicity
        case clr_white                  = "clr_white"                 //#FFFFFF

        case clr_orange_light           = "clr_orange_light"          //#FFAD3B (255, 173, 59)///
        case clr_yellow                 = "clr_yellow"                //#FFC247 (255, 194, 71)
        case paleOrangeColor            = "paleOrangeColor"           //#FFF1DE (255, 241, 222)
        case paleOrangeSolidColor       = "paleOrangeSolidColor"      //#FFE4BE (255, 228, 190)
        case searchHighlightColor       = "searchHighlightColor"      //#FFF3E1 (255, 243, 225)
        case clr_quiz_yellow            = "clr_quiz_yellow"           //#F59E25 (245, 158, 37, 1)
        
        case clr_orangeGrad1            = "clr_orangeGrad1"           //#F08D31 (255, 115, 140, 1)
        case clr_orangeGrad2            = "clr_orangeGrad2"           //#FFA523 (255, 165, 35, 1)
        case clr_orangeGrad3            = "clr_orangeGrad3"           //#FF738C (240, 141, 49, 1)

        case clr_greyDark               = "clr_greyDark"              //#424244 (66, 66, 68)
        case clr_greyDark1              = "clr_greyDark1"             //#2A2B2D (42, 43, 45)
        case toolTipGray                = "toolTipGray"               //#F4F4F3 (244, 244, 243)

        case clr_PrepAIPremiumBtn       = "PrepAIPremiumBtn"          //#FCB857 (252, 184, 87)
        case greenTrans_clr             = "greenTrans_clr"            //#EFFFFA (239, 255, 250)
        
        case darkBluePrepQuiz           = "darkBluePrepQuiz"          //#16202A (22, 32, 42)
        case GreyText                   = "GreyText"                  //#CED3D5 (206, 211, 213)
        case clr_voiceBlue              = "clr_voiceBlue"             //#1A68FF (26, 104, 255, 0.15);
        
        case borderCyanBlue             = "borderCyanBlue"            //##334052 (51, 64, 82)
        case borderDarkCyanBlue         = "borderDarkCyanBlue"        //##1C2939 (28, 41, 57)
 
        case clr_QuizBG                 = "clr_QuizBG"                //#1C2939 (28, 41, 57)
        case clr_Quiz_txt               = "clr_Quiz_txt"              //#7A8B94 (122, 139, 148)
        case ai_orangeClr               = "ai_orangeClr"              //#FFB448 (255, 180, 72, 1);
        case ai_greeClr                 = "ai_greeClr"                 //#2ADDA1 (42, 221, 161, 1);
        case ai_pinkClr                 = "ai_pinkClr"                 //#FF00B8 (255, 0, 184, 1)
        case clr_SucessGreen            = "clr_SucessGreen"             //#33A033
        case secondaryYellow            = "secondaryYellow"             //##FFCD87
        case prepShortsTitle            = "prepShortsTitle"             //##0072B2
        
        case clr_blueGradient           = "clr_blueGradient"           //#DAF2FF (218, 242, 255, 1)
        case clr_YellowGradient         = "clr_YellowGradient"         //#FFECD1 (255, 236, 209, 1)
        case clr_PurpleGradient         = "clr_PurpleGradient"         //#FFE0F6 (255, 224, 246, 1)
        
        case clr_bgGradient             = "clr_bgGradient"             //#DFF3FF (223, 243, 255, 1)

        var name: String { return self.rawValue }
    }
    
    @objc static var prepShortsTitle: UIColor {
        return color(named: .prepShortsTitle)
    }
    
    @objc static var secondaryYellow: UIColor {
        return color(named: .secondaryYellow)
    }
    
    @objc static var clr_SucessGreen: UIColor {
        return color(named: .clr_SucessGreen)
    }
    
    @objc static var borderDarkCyanBlue: UIColor {
        return color(named: .borderDarkCyanBlue)
    }
    
    @objc static var ai_orangeClr: UIColor {
        return color(named: .ai_orangeClr)
    }
     @objc static var ai_greeClr: UIColor {
        return color(named: .ai_greeClr)
    }
     @objc static var ai_pinkClr: UIColor {
        return color(named: .ai_pinkClr)
    }
    
    @objc static var borderCyanBlue: UIColor {
        return color(named: .borderCyanBlue)
    }
    
    @objc static var GreyText: UIColor {
        return color(named: .GreyText)
    }
    
    @objc static var clr_voiceBlue: UIColor {
        return color(named: .clr_voiceBlue)
    }
    
    @objc static var darkBluePrepQuiz: UIColor {
        return color(named: .darkBluePrepQuiz)
    }
    
    @objc static var lightBlueColor: UIColor {
        return color(named: .lightBlueColor)
    }
    
    @objc static var quizBlueColor: UIColor {
        return color(named: .quizBlueColor)
    }
    
    @objc static var clr_secondry_blue: UIColor {
        return color(named: .clr_secondry_blue)
    }
    
    @objc static var skyBlueColor: UIColor {
        return color(named: .skyBlueColor)
    }
    
    @objc static var paleOrangeSolidColor: UIColor {
        return color(named: .paleOrangeSolidColor)
    }
    
    @objc static var paleOrangeColor: UIColor {
        return color(named: .paleOrangeColor)
    }
    
    @objc static var errorRed_clr: UIColor {
        return color(named: .errorRed_clr)
    }
    
    @objc static var blackColor: UIColor {
        return color(named: .blackColor)
    }
    
    @objc static var clr_prepCompGreen: UIColor {
        return color(named: .clr_prepCompGreen)
    }
    
    @objc static var borderDarkColor: UIColor {
        return color(named: .borderDarkColor)
    }
    
    @objc static var clr_brown_light: UIColor {
        return color(named: .clr_brown_light)
    }
    
    @objc static var clr_red_dark: UIColor {
        return color(named: .clr_red_dark)
    }
    
    @objc static var clr_red_light: UIColor {
        return color(named: .clr_red_light)
    }
    
    @objc static var clr_green: UIColor {
        return color(named: .clr_green)
    }
    
    @objc static var clr_disable: UIColor {
        return color(named: .clr_disable)
    }
    @objc static var clr_disable_text: UIColor {
        return color(named: .clr_disable_text)
    }
    
    // Define colors used in various UIKit components or purposes
    @objc static var primaryColor: UIColor {
        return color(named: .primary)
    }
    
    @objc static var secondaryColor: UIColor {
        return color(named: .secondary)
    }
    
    @objc static var primaryMidnightBlue: UIColor {
        return color(named: .primaryMidnightBlue)
    }
    
    @objc static var borderColor: UIColor {
        return color(named: .border)
    }
    @objc static var onBordingClr: UIColor {
        return color(named: .onBordingClr)
    }
    
    @objc static var selectedCell_bgColor: UIColor {
        return color(named: .selectedCell_bgColor)
    }
    
    @objc static var clr_bgColor: UIColor {
        return color(named: .background)
    }
    @objc static var clr_white: UIColor {
        return color(named: .clr_white)
    }
    
    @objc static var searchHighlightColor: UIColor {
        return color(named: .searchHighlightColor)
    }
    @objc static var clr_quiz_yellow: UIColor {
        return color(named: .clr_quiz_yellow)
    }
    
    @objc static var clr_orangeGrad1: UIColor {
        return color(named: .clr_orangeGrad1)
    }
    @objc static var clr_orangeGrad2: UIColor {
        return color(named: .clr_orangeGrad2)
    }
    @objc static var clr_orangeGrad3: UIColor {
        return color(named: .clr_orangeGrad3)
    }
    
    @objc static var shadow_Color: UIColor {
        return color(named: .shadow_Color)
    }
    
    @objc static var separatorColor: UIColor {
        return color(named: .separator)
    }
    
    @objc static var appColor: UIColor {
        return color(named: .appColor)
    }
    
    @objc static var clr_yellow: UIColor {
        return color(named: .clr_yellow)
    }
    
    @objc static var clr_greyDark: UIColor {
        return color(named: .clr_greyDark)
    }
    @objc static var clr_greyDark1: UIColor {
        return color(named: .clr_greyDark1)
    }
    @objc static var toolTipGray: UIColor {
        return color(named: .toolTipGray)
    }
    @objc static var clr_StrongGreen: UIColor {
        return color(named: .clr_StrongGreen)
    } 
    @objc static var quiz_green: UIColor {
        return color(named: .quiz_green)
    }
    
    @objc static var clr_PrepAIPremiumBtn: UIColor {
        return color(named: .clr_PrepAIPremiumBtn)
    }
    @objc static var clr_orange_light: UIColor {
        return color(named: .clr_orange_light)
    } 
    
    @objc static var dotBlueColor: UIColor {
        return color(named: .dotBlueColor)
    }
    
    @objc static var clr_QuizBG: UIColor {
        return color(named: .clr_QuizBG)
    }
    
    @objc static var clr_Quiz_txt: UIColor {
        return color(named: .clr_Quiz_txt)
    }
    
    @objc static var clr_blueGradient: UIColor {
        return color(named: .clr_blueGradient)
    }
    @objc static var clr_YellowGradient: UIColor {
        return color(named: .clr_YellowGradient)
    }
    @objc static var clr_PurpleGradient: UIColor {
        return color(named: .clr_PurpleGradient)
    }
    
    @objc static var clr_bgGradient: UIColor {
        return color(named: .clr_bgGradient)
    }
    
    // Example of a common helper method for generating colors
    @objc static func colorWithAlpha(_ color: UIColor, alpha: CGFloat) -> UIColor {
        return color.withAlphaComponent(alpha)
    }
    
    // Retrieve a color from the asset catalog by name
    static func color(named name: ColorName) -> UIColor {
        let colorName = name.name
        
        guard let color = UIColor(named: colorName) else {
            debugPrint("Warning: Color named \(colorName) not found. Returning .clear.")
            return UIColor.clear
        }
        
        return color
    }
    
    @objc static func getHexColorString(_ color: UIColor) -> String {
        return hexStringFromColor(color: color)
    }
    
    static func hexStringFromColor(color: UIColor) -> String {
        let components = color.cgColor.components
        let r: CGFloat = components?[0] ?? 0.0
        let g: CGFloat = components?[1] ?? 0.0
        let b: CGFloat = components?[2] ?? 0.0
        
        let hexString = String.init(format: "#%02lX%02lX%02lX", lroundf(Float(r * 255)), lroundf(Float(g * 255)), lroundf(Float(b * 255)))
        return hexString
    }
}



