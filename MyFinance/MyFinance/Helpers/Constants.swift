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
    struct AlertMessage {
        static let mandatoryFieldAlert = "Please fill all mandatory fields"
    }
    enum FinancialService: String, CaseIterable {
        case financePlanner = "Financial Planner"
        case wealthCreation = "Wealth Creation"
    }
    
}


