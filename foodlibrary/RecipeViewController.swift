//
//  RecipeViewController.swift
//  foodlibrary
//
//  Created by Tommy Le on 2016-07-01.
//  Copyright © 2016 Tommy Le. All rights reserved.
//

import UIKit

class RecipeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, EditRecipeViewControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var recipe: Recipe!
    var data = [[]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(editTapped))
        
        self.tableView.registerNib(UINib(nibName: "IngredientTableViewCell", bundle: nil), forCellReuseIdentifier: "IngredientTableViewCell")
        
        self.tableView.registerNib(UINib(nibName: "RecipeTitleTableViewCell", bundle: nil), forCellReuseIdentifier: "RecipeTitleTableViewCell")
        
        self.tableView.registerNib(UINib(nibName: "InformationTableViewCell", bundle: nil), forCellReuseIdentifier: "InformationTableViewCell")
        
        self.tableView.registerNib(UINib(nibName: "InstructionTableViewCell", bundle: nil), forCellReuseIdentifier: "InstructionTableViewCell")

        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        // Parallax Header
        let headerView = ParallaxHeader.instanciateFromNib()
        let filePath = (applicationDocumentsDirectory as NSString).stringByAppendingPathComponent(self.recipe.imagePath!)
        
        headerView.backgroundImage.image = UIImage(contentsOfFile: filePath)
        
        self.tableView.parallaxHeader.view = headerView
        self.tableView.parallaxHeader.height = 250
        self.tableView.parallaxHeader.mode = MXParallaxHeaderMode.Fill
        self.tableView.parallaxHeader.minimumHeight = 0
        
        self.tableView.backgroundColor = UIColor.clearColor()
        
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
            sectionHeaderView.headerTitle.text = "INGREDIENTS"
            sectionHeaderView.sectionImage.image = UIImage(named: "Ingredients")
            
//            sectionHeaderView.sectionImage.image = sectionHeaderView.sectionImage.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
//            sectionHeaderView.sectionImage.tintColor = Helper.UIColorFromRGB(0x89D486)
            
            return sectionHeaderView
        default:
            let sectionHeaderView = SectionHeaderView.instanciateFromNib()
            sectionHeaderView.headerTitle.text = "PREPARATION"
            sectionHeaderView.sectionImage.image = UIImage(named: "Preparations")
            
            return sectionHeaderView
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 50
        case 1:
            return 122
        default:
            return 122
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
            
            let tempCell = tableView.dequeueReusableCellWithIdentifier("InstructionTableViewCell", forIndexPath: indexPath) as! InstructionTableViewCell
            
            let instruction:Instruction = data[indexPath.section][indexPath.row] as! Instruction
            
            tempCell.setInstruction(indexPath.row + 1, instructionText: instruction.text!)
            
            cell = tempCell
            
        default:
            cell = tableView.dequeueReusableCellWithIdentifier("InformationTableViewCell", forIndexPath: indexPath) as! InformationTableViewCell
            
            (cell as! InformationTableViewCell).timeLabel.attributedText = Helper.StyleTime("10 min", cookTime: "1 hr")
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {

        switch indexPath.section {
        default:
            return UITableViewAutomaticDimension
        }
        
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    
        switch indexPath.section {
        default:
            return UITableViewAutomaticDimension
        }
    
    }
    
    //MARK: Actions
    func editTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("EditRecipeViewController") as! EditRecipeViewController
        vc.recipe = recipe
        vc.category = recipe.category
        vc.delegate = self
        
        let nav:UINavigationController = UINavigationController.init(rootViewController: vc)
        
        self.navigationController?.presentViewController(nav, animated: true, completion: nil)
    }
    
    //MARK: EditRecipeViewControllerDelegate
    func didSaveRecipe(sender: EditRecipeViewController) {
        self.recipe = sender.recipe
        self.data = [["Header"], self.recipe.ingredients!.array, self.recipe.instructions!.array]
        self.tableView.reloadData()
    }
}
