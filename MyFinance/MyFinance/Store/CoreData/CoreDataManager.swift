//
//  CoreDataManager.swift
//  MyFinance
//
//  Created by Shwetha Surendran on 15/12/21.
//

import Foundation
import CoreData


protocol DatabaseProtocol {
    mutating func save(userProfileDetails model: FinancialProfileModel, forUser emailId: String)
    mutating func getUserProfileDetails(withEmail emailId: String)-> [FinancialProfileModel]?
}

struct CoreDataManager {
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                //TODO:Handle this case
                fatalError()
            }
        }
        return container
    }()
    
    mutating func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                //TODO:Handle this case
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}



extension CoreDataManager: DatabaseProtocol {
    
    mutating func save(userProfileDetails model: FinancialProfileModel, forUser emailId: String) {
        let userObject = getUserManagedObject(from: emailId)
        
        let categoryObject = getCategoryManagedObject(from: model, withUser: userObject)
        
        for each in model.items.unwrappedValue {
            let itemObject = getItemManagedObject(from: each, withCategory: categoryObject)
            categoryObject.addToItems(itemObject)
        }
        
        userObject.addToCategories(categoryObject)
        saveContext()
    }
    
    mutating func getUserProfileDetails(withEmail emailId: String)-> [FinancialProfileModel]? {
        guard let existingUser = getExistingUser(withEmail: emailId) else {
            return nil
        }
        let parsedModels = parseManagedObjectsToModel(from: existingUser)
        return parsedModels
    }
    
    private func parseManagedObjectsToModel(from user: User?)-> [FinancialProfileModel]? {
        guard let user = user else {return nil}
        
        let categoryObjects: [ProfileCategory] = (user.categories?.allObjects as? [ProfileCategory]).unwrappedValue
        
        var categoryModels: [FinancialProfileModel] = []
        
        for category in categoryObjects {
            
            let itemObjects: [Item] = (category.items?.allObjects as? [Item]).unwrappedValue
            
            var itemModels: [FinancialProfileItemModel] = []
            
            for item in itemObjects {
                let itemModel = FinancialProfileItemModel(title: item.title, type: UIType(rawValue: item.type.unwrappedValue), options: item.options, value: item.value, isMandatory: item.isMandatory)
                itemModels.append(itemModel)
            }
            
            let categoryModel = FinancialProfileModel(category: FinancialProfileCategory(rawValue: category.name.unwrappedValue), items: itemModels, tip: (category.tip).unwrappedValue, index: Int(category.index))
            
            categoryModels.append(categoryModel)
        }
        //sort based on index
        let sortedCategoryModels = categoryModels.sorted(by: {$0.index.unwrappedValue < $1.index.unwrappedValue})
        return sortedCategoryModels
    }
    
    private mutating func getUserManagedObject(from emailId: String)-> User {
        guard let existingUser = getExistingUser(withEmail: emailId) else {
            let user = User(context: persistentContainer.viewContext)
            user.email = emailId
            return user
        }
        return existingUser
    }
    
    private mutating func getExistingUser(withEmail emailId: String)-> User? {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate.init(format: "email == %@", emailId)
        let userObject = try? persistentContainer.viewContext.fetch(fetchRequest)
        return userObject?.first
    }
    
    private mutating func getCategoryManagedObject(from model: FinancialProfileModel, withUser user: User)-> ProfileCategory {
        let existingCategoryObjects: [ProfileCategory] = (user.categories?.allObjects as? [ProfileCategory]).unwrappedValue
        let filteredCategoryObjects = existingCategoryObjects.filter({$0.name == model.category?.rawValue})
        
        guard filteredCategoryObjects.count > 0, let categoryObject = filteredCategoryObjects.first else {
            let category = ProfileCategory(context: persistentContainer.viewContext)
            category.name = model.category?.rawValue
            category.tip = model.tip
            category.index = Int16(model.index.unwrappedValue)
            return category
        }
        
        return categoryObject
    }
    
    private mutating func getItemManagedObject(from model: FinancialProfileItemModel, withCategory category: ProfileCategory)-> Item {
        let existingItems = (category.items?.allObjects as? [Item]).unwrappedValue
        let filteredItems = existingItems.filter({$0.title == model.title})
        
        guard filteredItems.count > 0, let existingItem = filteredItems.first else {
            let item = Item(context: persistentContainer.viewContext)
            item.title = model.title
            item.type = model.type?.rawValue
            item.value = model.value
            item.isMandatory = model.isMandatory.unwrappedValue
            item.options = model.options
            return item
        }
        
        existingItem.value = model.value
        return existingItem
    }
    
}
