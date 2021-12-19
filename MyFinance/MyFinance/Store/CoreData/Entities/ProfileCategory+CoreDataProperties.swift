//
//  ProfileCategory+CoreDataProperties.swift
//  MyFinance
//
//  Created by Shwetha Surendran on 16/12/21.
//
//

import Foundation
import CoreData


extension ProfileCategory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProfileCategory> {
        return NSFetchRequest<ProfileCategory>(entityName: "ProfileCategory")
    }

    @NSManaged public var name: String?
    @NSManaged public var tip: String?
    @NSManaged public var index: Int16
    @NSManaged public var items: NSSet?

}

// MARK: Generated accessors for items
extension ProfileCategory {

    @objc(addItemsObject:)
    @NSManaged public func addToItems(_ value: Item)

    @objc(removeItemsObject:)
    @NSManaged public func removeFromItems(_ value: Item)

    @objc(addItems:)
    @NSManaged public func addToItems(_ values: NSSet)

    @objc(removeItems:)
    @NSManaged public func removeFromItems(_ values: NSSet)

}

extension ProfileCategory : Identifiable {

}
