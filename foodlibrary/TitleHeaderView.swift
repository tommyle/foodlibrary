//
//  TitleHeaderView.swift
//  foodlibrary
//
//  Created by Tommy Le on 2016-07-02.
//  Copyright © 2016 Tommy Le. All rights reserved.
//

import UIKit

class TitleHeaderView: UIView {

    @IBOutlet weak var headerTitle: UILabel!
    
    class func instanciateFromNib() -> TitleHeaderView {
        return NSBundle.mainBundle().loadNibNamed("TitleHeaderView", owner: nil, options: nil)[0] as! TitleHeaderView
    }
}
