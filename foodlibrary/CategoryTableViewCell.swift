//
//  CategoryTableViewCell.swift
//  foodlibrary
//
//  Created by Tommy Le on 2016-07-11.
//  Copyright © 2016 Tommy Le. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var count: UILabel!
    @IBOutlet weak var iconLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
//        count.backgroundColor = Helper.UIColorFromRGB(0xff7537)
//        count.layer.cornerRadius = count.frame.size.height / 2
//        count.layer.masksToBounds = true
//        count.textColor = UIColor.whiteColor()
        
        iconLabel.backgroundColor = Helper.UIColorFromRGB(0xff7537)
        iconLabel.layer.cornerRadius = 4
        iconLabel.layer.masksToBounds = true
        iconLabel.textColor = UIColor.whiteColor()
        iconLabel.alpha = 0.9
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCategoryLabel(text: String?) {
        if (text != nil) {
            label?.text = text!
            iconLabel?.text = text![0]
        }
    }
    
    func setCountLabel(num: Int) {
        if (num == 1) {
            self.count?.text = String(num) + " recipe"
        }
        else {
            self.count?.text = String(num) + " recipes"
        }
    }
}

extension String {
    
    subscript (i: Int) -> Character {
        return self[self.startIndex.advancedBy(i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript (r: Range<Int>) -> String {
        let start = startIndex.advancedBy(r.startIndex)
        let end = start.advancedBy(r.endIndex - r.startIndex)
        return self[Range(start ..< end)]
    }
}
