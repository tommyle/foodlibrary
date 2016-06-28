//
//  ParallaxHeader.swift
//  foodlibrary
//
//  Created by Tommy Le on 2016-06-18.
//  Copyright © 2016 Tommy Le. All rights reserved.
//

import UIKit

class ParallaxHeader: UIView {

    @IBOutlet weak var backgroundImage: UIImageView!
    
    class func instanciateFromNib() -> ParallaxHeader {
        return NSBundle.mainBundle().loadNibNamed("ParallaxHeader", owner: nil, options: nil)[0] as! ParallaxHeader
    }
    
}
