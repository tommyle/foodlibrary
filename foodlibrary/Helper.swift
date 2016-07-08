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
        //        let regularAttributes = [NSForegroundColorAttributeName: UIColor.greenColor(), NSBackgroundColorAttributeName: UIColor.clearColor(), NSFontAttributeName: UIFont(name: "Oxygen-Bold", size: 18)!]
        
        let boldAttributes = [NSFontAttributeName: UIFont(name: "Oxygen-Bold", size: 18)!]
        let regularAttributes = [NSFontAttributeName: UIFont(name: "Oxygen-Regular", size: 18)!]
        
        let prepTimeString: NSString = "Prep: \(prepTime)"
        let cookTimeString: NSString = "  Cook: \(cookTime)"
        
        let prepTimeAttributedString = NSMutableAttributedString(string: prepTimeString as String)
        prepTimeAttributedString.addAttributes(boldAttributes, range: prepTimeString.rangeOfString("Prep:"))
        prepTimeAttributedString.addAttributes(regularAttributes, range: prepTimeString.rangeOfString(prepTime))
        
        let cookTimeAttributedString = NSMutableAttributedString(string: cookTimeString as String)
        cookTimeAttributedString.addAttributes(boldAttributes, range: cookTimeString.rangeOfString("Cook:"))
        cookTimeAttributedString.addAttributes(regularAttributes, range: cookTimeString.rangeOfString(cookTime))
        
        prepTimeAttributedString.appendAttributedString(cookTimeAttributedString)

        return prepTimeAttributedString
    }
    
    static func minutesToString(totalMinutes:Int32)->String {
        let hours:Int32 = totalMinutes / 60
        let minutes:Int32 = totalMinutes - hours * 60
        
        if (hours <= 0) {
            return "\(minutes) mins"
        }
        else {
            return "\(hours) hrs \(minutes) mins"
        }
    }
    
    static func dateToString(date: NSDate?) -> String {
        if (date == nil) {
            return "0 mins"
        }
        
        let calendar = NSCalendar.currentCalendar()
        let comp = calendar.components([.Hour, .Minute], fromDate: date!)
        let hour = comp.hour
        let minute = comp.minute
        
        if (hour <= 0) {
            return "\(minute) mins"
        }
        else {
            return "\(hour) hrs \(minute) mins"
        }
    }
    
    static func stringToDate(hhmm: String!) -> NSDate {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let dateObj = dateFormatter.dateFromString(hhmm)

        return dateObj!
    }
}