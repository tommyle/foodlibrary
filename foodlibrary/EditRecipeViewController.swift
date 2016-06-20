//
//  EditRecipeViewController.swift
//  foodlibrary
//
//  Created by Tommy Le on 2016-06-18.
//  Copyright © 2016 Tommy Le. All rights reserved.
//

import UIKit

class EditRecipeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var category: Category!
    var sections: NSMutableArray!
    var recipe: Recipe!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .Plain, target: self, action: #selector(doneTapped))
        
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.registerNib(UINib(nibName: "EditRecipeTableViewCell", bundle: nil), forCellReuseIdentifier: "EditRecipeTableViewCell")
        self.tableView.registerNib(UINib(nibName: "EditInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "EditInfoTableViewCell")
        
        self.sections = ["Information", "Ingredients", "Directions"]
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: UITableViewDelegate
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let sectionTitle:String = (sections[indexPath.section] as? String)!
        
        switch sectionTitle {
        case "Information":
            return 400
        default:
            return 100
        }
    }
    
//    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        return UITableViewAutomaticDimension
//    }
    
    func tableView( tableView : UITableView,  titleForHeaderInSection section: Int)->String? {
        return sections[section] as? String
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let sectionTitle:String = (sections[indexPath.section] as? String)!

        let cellId: String!
        let cell: UITableViewCell!
        
        switch sectionTitle {
        case "Ingredients":
            cellId = "EditRecipeTableViewCell"
            cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath) as! EditRecipeTableViewCell
        case "Directions":
            cellId = "EditRecipeTableViewCell"
            cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath) as! EditRecipeTableViewCell
        default:
            cellId = "EditInfoTableViewCell"
            cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath) as! EditInfoTableViewCell
        }
        
        switch sectionTitle {
        case "Ingredients":
            (cell as! EditRecipeTableViewCell).textView.text = "1 cup of wheat\n1/2 ounce of coconuts"
        case "Directions":
            (cell as! EditRecipeTableViewCell).textView.text = "1. Open the box\n2. Put ingredients in the box.\n3. Bake for 100 hours"
        case "Information":
            break
        default:
            break
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    // MARK: Actions
    
    func doneTapped() {
        self.createRecipe()
        self.saveContext()
        
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: MagicalRecord
    
    func createRecipe() {
        recipe = Recipe.createEntity() as! Recipe
        
        for i in 0...tableView.numberOfSections - 1 {
            let indexPath = NSIndexPath(forRow: 0, inSection: i)
            
            tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Top, animated: false)
            
            
            let sectionTitle:String = (sections[i] as? String)!
            
            let cellId: String!
            
            switch sectionTitle {
            case "Ingredients":
                cellId = "EditRecipeTableViewCell"
                
                let cell: EditRecipeTableViewCell!
                cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath) as! EditRecipeTableViewCell
                
                let ingredients: NSMutableOrderedSet! = recipe.mutableOrderedSetValueForKey("ingredients")
                
                let ingredientsArray = cell.textView.text.characters.split{$0 == "\n"}.map(String.init)
                
                for ingredientText in ingredientsArray {
                    let ingredient: Ingredient!
                    ingredient = Ingredient.createEntity() as! Ingredient
                    ingredient.name = ingredientText
                    ingredients.addObject(ingredient)
                }
                
                recipe.ingredients = ingredients
            case "Directions":
                cellId = "EditRecipeTableViewCell"

                let cell: EditRecipeTableViewCell!
                cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath) as! EditRecipeTableViewCell

                let instructions: NSMutableOrderedSet! = recipe.mutableOrderedSetValueForKey("instructions")
                
                let instructionsArray = cell.textView.text.characters.split{$0 == "\n"}.map(String.init)
                
                for instructionText in instructionsArray {
                    let instruction: Instruction!
                    instruction = Instruction.createEntity() as! Instruction
                    instruction.text = instructionText
                    
                    instructions.addObject(instruction)
                }
                
                recipe.instructions = instructions
                
            default:
                break;
            }
        }
    }
    
    func saveContext() {
        NSManagedObjectContext.defaultContext().saveToPersistentStoreAndWait()
    }
}
