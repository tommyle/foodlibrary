//
//  Recipe+CoreDataProperties.swift
//  
//
//  Created by Tommy Le on 2016-06-19.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Recipe {

    @NSManaged var cookTime: NSNumber?
    @NSManaged var difficulty: NSNumber?
    @NSManaged var imagePath: String?
    @NSManaged var name: String?
    @NSManaged var prepTime: NSNumber?
    @NSManaged var servings: NSNumber?
    @NSManaged var category: Category?
    @NSManaged var ingredients: NSOrderedSet?
    @NSManaged var instructions: NSOrderedSet?

}
