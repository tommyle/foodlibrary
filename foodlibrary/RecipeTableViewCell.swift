//
//  RecipeTableViewCell.swift
//  foodlibrary
//
//  Created by Tommy Le on 2016-06-19.
//  Copyright © 2016 Tommy Le. All rights reserved.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.textLabel?.numberOfLines = 0
        self.selectionStyle = UITableViewCellSelectionStyle.None
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
