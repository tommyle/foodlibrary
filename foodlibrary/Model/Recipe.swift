//
//  Recipe.swift
//  
//
//  Created by Tommy Le on 2016-06-26.
//
//

import Foundation
import CoreData

@objc(Recipe)
class Recipe: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    func getInstructinsAsString() -> String {
        var iString = String()
        
        for i in instructions! {
            iString += "\((i as! Instruction).text!)\n"
        }
        
        return iString
    }
    
    func getIngredientsAsString() -> String {
        var iString = String()
        
        for i in ingredients! {
            iString += "\((i as! Ingredient).name!)\n"
        }
        
        return iString
    }
    
    func deleteAllIngredients() {
        for i in self.ingredients! {
            (i as! Ingredient).deleteEntity()
        }
    }
    
    func deleteAllInstructions() {
        for i in self.instructions! {
            (i as! Instruction).deleteEntity()
        }
    }
}
