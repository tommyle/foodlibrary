//
//  Category+CoreDataProperties.swift
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

extension Category {

    @NSManaged var name: String?
    @NSManaged var recipes: NSSet?

}
