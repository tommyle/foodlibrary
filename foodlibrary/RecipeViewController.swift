//
//  RecipeViewController.swift
//  foodlibrary
//
//  Created by Tommy Le on 2016-06-19.
//  Copyright © 2016 Tommy Le. All rights reserved.
//

import UIKit

class RecipeViewController: UIViewController {
    
    var vc:RecipeTableViewController!
    var category: Category!
    var recipe: Recipe!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "tableViewSegue") {
            vc = segue.destinationViewController as! RecipeTableViewController
            vc.recipe = self.recipe
            vc.category = self.category
        }
    }
}
