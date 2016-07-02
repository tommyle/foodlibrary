//
//  RecipeExViewController.swift
//  foodlibrary
//
//  Created by Tommy Le on 2016-07-01.
//  Copyright © 2016 Tommy Le. All rights reserved.
//

import UIKit

class RecipeExViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var recipe: Recipe!
    var data = [[]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerNib(UINib(nibName: "IngredientTableViewCell", bundle: nil), forCellReuseIdentifier: "IngredientTableViewCell")
        
        self.tableView.registerNib(UINib(nibName: "RecipeTitleTableViewCell", bundle: nil), forCellReuseIdentifier: "RecipeTitleTableViewCell")
        
        self.tableView.registerNib(UINib(nibName: "InformationTableViewCell", bundle: nil), forCellReuseIdentifier: "InformationTableViewCell")

        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        // Parallax Header
        let headerView = ParallaxHeader.instanciateFromNib()
        headerView.backgroundImage.image = UIImage(named: "sushi")//UIImage(contentsOfFile: self.recipe.imagePath!)
        
        self.tableView.parallaxHeader.view = headerView
        self.tableView.parallaxHeader.height = 250
        self.tableView.parallaxHeader.mode = MXParallaxHeaderMode.Fill
        self.tableView.parallaxHeader.minimumHeight = 0
        
        self.tableView.backgroundColor = Helper.UIColorFromRGB(0xeaf1f6)
        
        self.data = [["Header"], recipe.ingredients!.array, recipe.instructions!.array]
    }
    
    // MARK: Helper Methods
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
    
    // MARK: - TableViewDelegate
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.data.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data[section].count
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            let titleHeaderView = TitleHeaderView.instanciateFromNib()
            titleHeaderView.headerTitle.text = self.recipe.name
            
            return titleHeaderView
        case 1:
            let sectionHeaderView = SectionHeaderView.instanciateFromNib()
            sectionHeaderView.headerTitle.text = "Ingredients"
            
            return sectionHeaderView
        default:
            let sectionHeaderView = SectionHeaderView.instanciateFromNib()
            sectionHeaderView.headerTitle.text = "Preparation"
            
            return sectionHeaderView
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 50
        case 1:
            return 44
        default:
            return 44
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell
        
        switch indexPath.section {
        case 1:
            cell = tableView.dequeueReusableCellWithIdentifier("IngredientTableViewCell", forIndexPath: indexPath) as! IngredientTableViewCell
            
            let ingredient:Ingredient = data[indexPath.section][indexPath.row] as! Ingredient
            (cell as! IngredientTableViewCell).ingredientLabel.text = ingredient.name
        case 2:
            cell = tableView.dequeueReusableCellWithIdentifier("IngredientTableViewCell", forIndexPath: indexPath) as! IngredientTableViewCell

            let instruction:Instruction = data[indexPath.section][indexPath.row] as! Instruction
            (cell as! IngredientTableViewCell).ingredientLabel.text = instruction.text
        default:
            cell = tableView.dequeueReusableCellWithIdentifier("InformationTableViewCell", forIndexPath: indexPath) as! InformationTableViewCell
            
//            (cell as! InformationTableViewCell).titleLabel.text = data[indexPath.section][indexPath.row] as? String
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
