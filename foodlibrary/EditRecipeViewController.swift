//
//  EditRecipeViewController.swift
//  foodlibrary
//
//  Created by Tommy Le on 2016-06-21.
//  Copyright © 2016 Tommy Le. All rights reserved.
//

import UIKit

class EditRecipeViewController: UIViewController {

    var vc:EditRecipeTableViewController!
    var category: Category!
    var recipe: Recipe!
    
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .Plain, target: self, action: #selector(saveTapped))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: #selector(cancelTapped))

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "tableViewSegue") {
            vc = segue.destinationViewController as! EditRecipeTableViewController
        }
    }
    
    // MARK: Helper Functions
    
    // MARK: Actions
    
    func saveTapped() {
        self.createRecipe()
        self.saveContext()
        
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func cancelTapped() {
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: MagicalRecord
    
    func createRecipe() {
        self.recipe = Recipe.createEntity() as! Recipe
        self.recipe.name = vc.nameTextField.text
        
        self.recipe.cookTime = vc.cookTimePicker.date
        self.recipe.prepTime = vc.prepTimePicker.date
        
        self.recipe.difficulty = 5
        
        let ingredients: NSMutableOrderedSet! = recipe.mutableOrderedSetValueForKey("ingredients")
        
        let ingredientsArray = vc.ingredientsTextView.text.characters.split{$0 == "\n"}.map(String.init)
        
        for ingredientText in ingredientsArray {
            let ingredient: Ingredient!
            ingredient = Ingredient.createEntity() as! Ingredient
            ingredient.name = ingredientText
            ingredients.addObject(ingredient)
        }
        
        recipe.ingredients = ingredients

        let instructions: NSMutableOrderedSet! = recipe.mutableOrderedSetValueForKey("instructions")
        
        let instructionsArray = vc.instructionsTextView.text.characters.split{$0 == "\n"}.map(String.init)
        
        for instructionText in instructionsArray {
            let instruction: Instruction!
            instruction = Instruction.createEntity() as! Instruction
            instruction.text = instructionText
            
            instructions.addObject(instruction)
        }
        
        recipe.instructions = instructions
    }
    
    func saveContext() {
        NSManagedObjectContext.defaultContext().saveToPersistentStoreAndWait()
    }
}
