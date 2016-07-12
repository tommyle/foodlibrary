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
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator;

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
