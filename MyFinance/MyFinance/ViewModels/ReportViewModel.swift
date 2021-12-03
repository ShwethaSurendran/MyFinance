//
//  ReportViewModel.swift
//  MyFinance
//
//  Created by Shwetha Surendran on 02/12/21.
//

import UIKit

struct ReportViewModel {
    
    var updatedProfileData: Observable<[FinancialProfileModel]?> = Observable(nil)
    
    init(existingProfileData : [FinancialProfileModel]) {
        prepareReportData(profileData: existingProfileData)
    }
    
    /// Analyse and update profile data with suggestions, based on user submitted details
    /// - Parameter profileData: User submitted profile details
    mutating func prepareReportData(profileData: [FinancialProfileModel]) {
        var profileData = profileData
        for index in 0..<profileData.count {
            let tipMessage = analyseAndGetTip(forFinancialCategory: profileData[index].category, from: profileData)
            profileData[index].tip = tipMessage
        }
        
        let emergencyFundData = FinancialProfileModel(category: .emergencyPlanning, items: [], tip: "Put 6 months of your expense into a short term debt instrument. \nRecomme...........")
        profileData.append(emergencyFundData)
        updatedProfileData.value = profileData
    }
    
    /// Analyse User profile details and generate suggestions.
    /// - Parameters:
    ///   - category: Financial category like Income, Expense etc.
    ///   - profileData: User submitted profile details
    /// - Returns: Tip generated for specified category
    func analyseAndGetTip(forFinancialCategory category: FinancialProfileCategory?, from profileData: [FinancialProfileModel])-> String {
        guard let category = category else {
            return ""
        }
        var tip = "\nTotal \(category.rawValue) : ₹\(getTotalAmount(forCategory:category, from: profileData))\n"
        switch category {
        case .income:
            if !isGoodIncomeOrAssetAllocation(forProfileDetails: profileData, category: .income) {
                tip += "\nDiversify your source of income.\n"
            }
            return tip
        case .expenses:
            if !isGoodExpenseRatio(forProfileDetails: profileData) {
                return (tip + "\nLimit your expense\nFollow 50:30:20 rule \n 50% of Income for expense \n 30% of Income for long term goals \n 20% of Income for short term goals\n")
            }
            return tip
        case .liabilities:
            return tip
        case .assets:
            tip += "\nTotal NetWorth : ₹\(getTotalNetWorth(forProfileDetails: profileData))\n"
            if !isGoodIncomeOrAssetAllocation(forProfileDetails: profileData, category: .assets) {
                tip += "\nDiversify your asset allocations.\n"
            }
            return tip
        case .insurance:
            tip = getInsuranceData(forProfileDetails: profileData)
            if !isGoodInsuranceSubscription(forProfileDetails: profileData) {
                tip += "\nTake a term life insurance 15-20 times of your annual income.\nTake Health insurance of 10-15 lakhs, Add a super topup.\n"
            }else {
                tip += "\n\nHuraay.... you already purchased 👍"
            }
            return tip
        default:
            return ""
        }
    }
    
    /// Returns total amount of user submitted values for specified category
    /// - Parameters:
    ///   - category: Financial category like Income, Expense etc.
    ///   - profileData: User submitted profile details
    /// - Returns: Calculated total amount
    func getTotalAmount(forCategory category: FinancialProfileCategory, from profileData: [FinancialProfileModel])-> Double {
        let divisions = getDivisions(forCategory: category, from: profileData)
        return divisions.reduce(0, +)
    }
    
    /// Returns list of amount submitted for different types under specified Financial Category
    /// - Parameters:
    ///   - category: Financial category like Income, Expense etc.
    ///   - profileData: User submitted profile details
    /// - Returns: Array of values
    func getDivisions(forCategory category: FinancialProfileCategory, from profileData: [FinancialProfileModel])-> [Double] {
        let profileModel = profileData.filter({$0.category == category}).first
        let items: [FinancialProfileItemModel] = profileModel?.items ?? []
        return items.compactMap({Double($0.value ?? "0")})
    }
    
    /// Check if Income/Asset allocations are good enough
    /// - Parameters:
    ///   - profileData: User submitted profile details
    ///   - category: Financial category like Income, Expense etc.
    /// - Returns: Boolean value indicating Income/Asset allocations are good
    func isGoodIncomeOrAssetAllocation(forProfileDetails profileData: [FinancialProfileModel], category: FinancialProfileCategory?)-> Bool {
        guard let category = category else {
            return false
        }
        return getDivisions(forCategory: category, from: profileData).count > 1
    }
    
    /// Check if User submitted expense details are good enough based on the income
    /// - Parameter profileData: User submitted profile details
    /// - Returns: Boolean value indicating if User submitted expense ratio is good
    func isGoodExpenseRatio(forProfileDetails profileData: [FinancialProfileModel])-> Bool {
        let totalExpense = getTotalAmount(forCategory: .expenses, from: profileData)
        let totalIncome = getTotalAmount(forCategory: .income, from: profileData)
        let correctExpenseRatio = totalIncome * 0.5
        return totalExpense > correctExpenseRatio ? false : true
    }
    
    /// Calculate total networth of the User from asset allocations and liabilities
    /// - Parameter profileData: User submitted profile details
    /// - Returns: Value obtained by subtracting liabilities from total asset allocations
    func getTotalNetWorth(forProfileDetails profileData: [FinancialProfileModel])-> Double {
        let totalAssets = getTotalAmount(forCategory: .assets, from: profileData)
        let totalLiabilities = getTotalAmount(forCategory: .liabilities, from: profileData)
        return (totalAssets - totalLiabilities) > 0 ? (totalAssets - totalLiabilities) : 0
    }
    
    /// Check if User have needed insurance subscriptions
    /// - Parameter profileData: User submitted profile details
    /// - Returns: Boolean value indicating if User have needed insurance subscriptions
    func isGoodInsuranceSubscription(forProfileDetails profileData: [FinancialProfileModel])-> Bool {
        return getDivisions(forCategory: .insurance, from: profileData).count > 0
    }
    
    /// Loop through the User submitted insurance details and combine it to a string
    /// - Parameter profileData: User submitted profile details
    /// - Returns: String value indicating each insurance type and associated amount
    func getInsuranceData(forProfileDetails profileData: [FinancialProfileModel])-> String {
        let profileModel = profileData.filter({$0.category == .insurance}).first
        let items: [FinancialProfileItemModel] = profileModel?.items ?? []
        var tip = ""
        for each in items {
            tip += "\n" + ((each.title ?? "") + " : ₹" + ((each.value ?? "0") == "" ? "0" : (each.value ?? "0")))
        }
        return tip
    }
    
}
