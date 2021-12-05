//
//  Constants.swift
//  MyFinance
//
//  Created by Shwetha Surendran on 23/11/21.
//

import UIKit

struct Constants {
    
    static let dotString = "."
    static let asteriskString = "*"
    
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
    struct ReportCategoryTip {
        static let singleSourceOfIncome = "\nDiversify your source of income.\n"
        static let moreExpenseRatio = "\nLimit your expense\nFollow 50:30:20 rule \n 50% of Income for expense \n 30% of Income for long term goals \n 20% of Income for short term goals\n"
        static let singleAssetAllocation = "\nDiversify your asset allocations.\n"
        static let noInsuranceSubscription = "\nTake a term life insurance 15-20 times of your annual income.\nTake Health insurance of 10-15 lakhs, Add a super topup.\n"
        static let haveInsuranceSubscription = "\n\nHuraay.... you already purchased 👍\n"
        static let emergencyFund = "\nPut 6 months of your expense into a short term debt instrument. \nRecommended Fund : Aditya Birla Sunlife Money Manager Fund\n"
    }
    struct ReportLabel {
        static let total = "Total"
        static let totalNetWorth = "Total NetWorth"
    }
    struct DateFormat {
        static let dateMonthYear = "dd/MM/yyyy"
    }
    struct ChartProperties {
        static let labelFont: UIFont = .systemFont(ofSize: 10)
        static let sliceSpace: CGFloat = 1.0
        static let holeRadius: CGFloat = 0.0
    }
    struct ChartValue {
        static let defaultAmount = "0"
        static let expenseRatio = 0.5
    }
    enum FinancialService: String, CaseIterable {
        case financePlanner = "Financial Planner"
    }
    
}


