//
//  Instruction+CoreDataProperties.swift
//  
//
//  Created by Tommy Le on 2016-06-26.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Instruction {

    @NSManaged var stepNumber: NSNumber?
    @NSManaged var text: String?
    @NSManaged var recipe: Recipe?

}
