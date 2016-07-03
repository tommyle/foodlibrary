//
//  Helper.swift
//  foodlibrary
//
//  Created by Tommy Le on 2016-07-02.
//  Copyright © 2016 Tommy Le. All rights reserved.
//

import UIKit

class Helper: NSObject {
    
    static func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    static func StyleTime(prepTime: String, cookTime: String) -> NSAttributedString{
        //Prep: 10 min Cook 2 min
        let fullString: NSString = "Prep: \(prepTime)  Cook: \(cookTime)"
        
        let boldAttributes = [NSFontAttributeName: UIFont(name: "Oxygen-Bold", size: 18)!]
        
        let regularAttributes = [NSFontAttributeName: UIFont(name: "Oxygen-Regular", size: 18)!]
        
//        let regularAttributes = [NSForegroundColorAttributeName: UIColor.greenColor(), NSBackgroundColorAttributeName: UIColor.clearColor(), NSFontAttributeName: UIFont(name: "Oxygen-Bold", size: 18)!]

        let attributedString = NSMutableAttributedString(string: fullString as String)
        
        attributedString.addAttributes(boldAttributes, range: fullString.rangeOfString("Prep:"))
        attributedString.addAttributes(regularAttributes, range: fullString.rangeOfString(prepTime))

        attributedString.addAttributes(boldAttributes, range: fullString.rangeOfString("Cook:"))
        attributedString.addAttributes(regularAttributes, range: fullString.rangeOfString(cookTime))

        return attributedString
    }
}