//
//  RecipeCollectionViewCell.swift
//  foodlibrary
//
//  Created by Tommy Le on 2016-07-10.
//  Copyright © 2016 Tommy Le. All rights reserved.
//

import UIKit

class RecipeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var borderView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.borderView.layer.borderColor = Helper.UIColorFromRGB(0xcfd5d8).CGColor
        self.borderView.layer.borderWidth = 1.0
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = Helper.UIColorFromRGB(0xcfd5d8).CGColor
        self.layer.shadowOffset = CGSizeMake(0.0, 1.0)
        self.layer.shadowOpacity = 0.1
        self.layer.shadowRadius = 1.0
        
        self.imageView.layer.masksToBounds = true
    }
    
    func setCell(title:String?, image:UIImage?) {
        self.titleLabel.text = title
        self.imageView.image = image
    }
}
