//
//  Category.swift
//  
//
//  Created by Tommy Le on 2016-06-26.
//
//

import Foundation
import CoreData

@objc(Category)
class Category: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    
    func fetchAllRecipes() -> [Recipe]! {
        let recipes = Recipe.findAllSortedBy("name", ascending: true) as! [Recipe]
        
        return recipes
    }
    
    func fetchRecipes() -> [Recipe]! {
        let predicate = NSPredicate(format: "category.name = %@", self.name!)
        let recipes = Recipe.findAllSortedBy("name", ascending: true, withPredicate: predicate) as! [Recipe]
        
        return recipes
    }
    
    func fetchCountAll() -> Int {
        let count = Recipe.numberOfEntities()
        
        return count as Int
    }
    
    func fetchCount() -> Int {
        let predicate = NSPredicate(format: "category.name = %@", self.name!)
        let count = Recipe.numberOfEntitiesWithPredicate(predicate)
        
        return count as Int
    }
}
