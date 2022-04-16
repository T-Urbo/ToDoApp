//
//  Item+CoreDataProperties.swift
//  ToDoListApp
//
//  Created by Timothey Urbanovich on 13/04/2022.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var createdAt: Date?
    @NSManaged public var isFinished: Bool
    @NSManaged public var name: String?

}

extension Item : Identifiable {

}
