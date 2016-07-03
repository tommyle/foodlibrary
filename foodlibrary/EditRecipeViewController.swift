//
//  EditRecipeViewController.swift
//  foodlibrary
//
//  Created by Tommy Le on 2016-06-21.
//  Copyright © 2016 Tommy Le. All rights reserved.
//

import UIKit

protocol EditRecipeViewControllerDelegate: class {
    func didSaveRecipe(sender: EditRecipeViewController)
}

class EditRecipeViewController: UIViewController {

    weak var delegate:EditRecipeViewControllerDelegate?
    
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
            vc.recipe = recipe
        }
    }
    
    // MARK: Helper Functions
    
    // MARK: Actions
    
    func saveTapped() {
        self.saveRecipe()
        self.saveContext()
        self.didSaveRecipe(self)
        
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func cancelTapped() {
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: MagicalRecord
    
    func saveRecipe() {
        //Delete old instructions and ingredients if they exist
        vc.recipe!.deleteAllIngredients()
        vc.recipe!.deleteAllInstructions()
        
        vc.recipe!.category = category
        vc.recipe!.name = vc.nameTextField.text
        vc.recipe!.cookTime = vc.cookTimePicker.date
        vc.recipe!.prepTime = vc.prepTimePicker.date
        
        let ingredients: NSMutableOrderedSet! = vc.recipe!.mutableOrderedSetValueForKey("ingredients")
        
        let ingredientsArray = vc.ingredientsTextView.text.characters.split{$0 == "\n"}.map(String.init)
        
        for ingredientText in ingredientsArray {
            let ingredient: Ingredient!
            ingredient = Ingredient.createEntity() as! Ingredient
            ingredient.name = ingredientText
            ingredients.addObject(ingredient)
        }
        
        vc.recipe!.ingredients = ingredients

        let instructions: NSMutableOrderedSet! = vc.recipe!.mutableOrderedSetValueForKey("instructions")
        
        let instructionsArray = vc.instructionsTextView.text.characters.split{$0 == "\n"}.map(String.init)
        
        for instructionText in instructionsArray {
            let instruction: Instruction!
            instruction = Instruction.createEntity() as! Instruction
            instruction.text = instructionText
            
            instructions.addObject(instruction)
        }
        
        vc.recipe!.instructions = instructions
    }
    
    func saveContext() {
        NSManagedObjectContext.defaultContext().saveToPersistentStoreAndWait()
    }
}

extension EditRecipeViewController: EditRecipeViewControllerDelegate {
    func didSaveRecipe(sender: EditRecipeViewController) {
        delegate?.didSaveRecipe(self)
    }
}