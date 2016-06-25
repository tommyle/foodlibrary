//
//  ExpandablePickerView.swift
//  foodlibrary
//
//  Created by Tommy Le on 2016-06-25.
//  Copyright © 2016 Tommy Le. All rights reserved.
//

import UIKit

class ExpandablePickerView: UIDatePicker {
    
    var visible: Bool?
    
    func showPicker() {
        self.visible = true
        self.hidden = false
        self.alpha = 0.0
        UIView.animateWithDuration(0.25, animations: {
            self.alpha = 1.0
        })
    }
    
    func hidePicker() {
        self.visible = false
        
        UIView.animateWithDuration(0.25, animations: {
            self.alpha = 0.0
            }, completion: { finished in
                self.hidden = true
        })
    }
}
