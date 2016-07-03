//
//  SectionHeaderView.swift
//  foodlibrary
//
//  Created by Tommy Le on 2016-07-02.
//  Copyright © 2016 Tommy Le. All rights reserved.
//

import UIKit

class SectionHeaderView: UIView {

    @IBOutlet weak var headerTitle: UILabel!
    @IBOutlet weak var sectionImage: UIImageView!
    
    class func instanciateFromNib() -> SectionHeaderView {
        return NSBundle.mainBundle().loadNibNamed("SectionHeaderView", owner: nil, options: nil)[0] as! SectionHeaderView
    }

}
