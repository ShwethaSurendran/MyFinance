//
//  Item+CoreDataProperties.swift
//  MyFinance
//
//  Created by Shwetha Surendran on 16/12/21.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var isMandatory: Bool
    @NSManaged public var options: [String]?
    @NSManaged public var title: String?
    @NSManaged public var type: String?
    @NSManaged public var value: String?

}

extension Item : Identifiable {

}
