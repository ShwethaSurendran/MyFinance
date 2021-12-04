//
//  Constants.swift
//  MyFinance
//
//  Created by Shwetha Surendran on 23/11/21.
//

import UIKit

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
    struct ReportTableProperties {
        static let sectionHeaderFontSize: CGFloat = 23.0
        static let chartSectionRowCount = 1
        static let basicProfileCellHeight: CGFloat = 40.0
    }
    enum FinancialService: String, CaseIterable {
        case financePlanner = "Financial Planner"
        case wealthCreation = "Wealth Creation"
    }
    
}


