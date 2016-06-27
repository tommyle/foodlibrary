//
//  RecipeTableViewController.swift
//  foodlibrary
//
//  Created by Tommy Le on 2016-06-25.
//  Copyright © 2016 Tommy Le. All rights reserved.
//

import UIKit

class RecipeTableViewController: UITableViewController {
    
    var category: Category!
    var recipe: Recipe!

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var difficultyTextField: UITextField!
    @IBOutlet weak var prepTimeTextField: UITextField!
    @IBOutlet weak var cookTimeTextField: UITextField!
    @IBOutlet weak var ingredientsTextView: UITextView!
    @IBOutlet weak var instructionsTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        self.tableView.parallaxHeader.view = NSBundle.mainBundle().loadNibNamed("RocketHeader", owner: self, options: nil).first as? UIView
        self.tableView.parallaxHeader.height = 300
        self.tableView.parallaxHeader.mode = MXParallaxHeaderMode.Fill
        self.tableView.parallaxHeader.minimumHeight = 20
        
        
        
//        self.headerView = ParallaxHeaderView.parallaxHeaderViewWithImage(UIImage(named: "bg-header"), forSize: CGSizeMake(self.tableView.frame.size.width, 200)) as! ParallaxHeaderView
//        self.tableView.tableHeaderView = self.headerView
        
        self.nameTextField.text = recipe.name
        
        self.cookTimeTextField.text = self.dateToString(self.recipe.cookTime!)
        self.prepTimeTextField.text = self.dateToString(self.recipe.prepTime!)
        
        self.difficultyTextField.text = recipe.difficulty?.stringValue
        
        var ingredientsString:String = ""
        for i in recipe.ingredients! {
            ingredientsString = ingredientsString + (i as! Ingredient).name! + "\n"
        }
        self.ingredientsTextView.text = ingredientsString
        
        var instructionsString:String = ""
        for i in recipe.instructions! {
            instructionsString = instructionsString + (i as! Instruction).text! + "\n"
        }
        self.instructionsTextView.text = instructionsString
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func minutesToString(totalMinutes:Int32)->String {
        let hours:Int32 = totalMinutes / 60
        let minutes:Int32 = totalMinutes - hours * 60
        
        if (hours <= 0) {
            return "\(minutes) mins"
        }
        else {
            return "\(hours) hrs \(minutes) mins"
        }
    }
    
    func dateToString(date: NSDate) -> String {
        let calendar = NSCalendar.currentCalendar()
        let comp = calendar.components([.Hour, .Minute], fromDate: date)
        let hour = comp.hour
        let minute = comp.minute
        
        if (hour <= 0) {
            return "\(minute) mins"
        }
        else {
            return "\(hour) hrs \(minute) mins"
        }
    }
    
    // MARK: - UIScrollViewDelegate
    
//    override func scrollViewDidScroll(scrollView: UIScrollView) {
//        headerView.layoutHeaderViewForScrollViewOffset(scrollView.contentOffset)
//        tableView.tableHeaderView = headerView
//    }
}
