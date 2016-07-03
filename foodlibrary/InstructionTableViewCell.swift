//
//  InstructionTableViewCell.swift
//  foodlibrary
//
//  Created by Tommy Le on 2016-07-02.
//  Copyright © 2016 Tommy Le. All rights reserved.
//

import UIKit

class InstructionTableViewCell: UITableViewCell {

    @IBOutlet weak var stepLabel: UILabel!
    @IBOutlet weak var instructionTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.stepLabel.layer.borderColor = Helper.UIColorFromRGB(0x434B5B).CGColor
        self.stepLabel.layer.borderWidth = 1.0;
        self.stepLabel.layer.cornerRadius = 34/2
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setInstruction(stepNumber: Int, instructionText: String) {
        
        self.stepLabel.text = String(stepNumber)
        self.instructionTextView.text = instructionText.stringByReplacingOccurrencesOfString("\n", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
        
        self.instructionTextView.sizeToFit()
    }
    
}
