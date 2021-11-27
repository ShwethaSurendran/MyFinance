//
//  Constants.swift
//  MyFinance
//
//  Created by Shwetha Surendran on 23/11/21.
//


struct Constants {
    struct Storyboard {
        static let main = "Main"
    }
    struct JsonFileNames {
        static let financePlannerCategories = "FinancePlannerCategories"
        static let wealthCreationCategories = "WealthCreationCategories"
    }
    struct FileExtension {
        static let json = "json"
    }
    enum FinancialService: String, CaseIterable {
        case financePlanner = "Financial Planner"
        case wealthCreation = "Wealth Creation"
    }

}


