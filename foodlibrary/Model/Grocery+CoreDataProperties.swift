//
//  Grocery+CoreDataProperties.swift
//  
//
//  Created by Tommy Le on 2016-07-13.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Grocery {

    @NSManaged var name: String?
    @NSManaged var recipeName: String?
    @NSManaged var category: String?

}
