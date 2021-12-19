//
//  User+CoreDataProperties.swift
//  MyFinance
//
//  Created by Shwetha Surendran on 16/12/21.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var email: String?
    @NSManaged public var name: String?
    @NSManaged public var categories: NSSet?

}

// MARK: Generated accessors for categories
extension User {

    @objc(addCategoriesObject:)
    @NSManaged public func addToCategories(_ value: ProfileCategory)

    @objc(removeCategoriesObject:)
    @NSManaged public func removeFromCategories(_ value: ProfileCategory)

    @objc(addCategories:)
    @NSManaged public func addToCategories(_ values: NSSet)

    @objc(removeCategories:)
    @NSManaged public func removeFromCategories(_ values: NSSet)

}

extension User : Identifiable {

}
