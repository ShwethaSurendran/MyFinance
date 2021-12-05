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
        
        let emergencyFundData = FinancialProfileModel(category: .emergencyPlanning, items: [], tip: Constants.ReportCategoryTip.emergencyFund)
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
        var tip = "\n\(Constants.ReportLabel.total) \(category.rawValue) : ₹\(getTotalAmount(forCategory:category, from: profileData))\n"
        switch category {
        case .income:
            if !isGoodIncomeOrAssetAllocation(forProfileDetails: profileData, category: .income) {
                tip += Constants.ReportCategoryTip.singleSourceOfIncome
            }
            return tip
        case .expenses:
            if !isGoodExpenseRatio(forProfileDetails: profileData) {
                return (tip + Constants.ReportCategoryTip.moreExpenseRatio)
            }
            return tip
        case .liabilities:
            return tip
        case .assets:
            tip += "\n\(Constants.ReportLabel.totalNetWorth) : ₹\(getTotalNetWorth(forProfileDetails: profileData))\n"
            if !isGoodIncomeOrAssetAllocation(forProfileDetails: profileData, category: .assets) {
                tip += Constants.ReportCategoryTip.singleAssetAllocation
            }
            return tip
        case .insurance:
            tip = getInsuranceData(forProfileDetails: profileData)
            if !isGoodInsuranceSubscription(forProfileDetails: profileData) {
                tip += Constants.ReportCategoryTip.noInsuranceSubscription
            }else {
                tip += Constants.ReportCategoryTip.haveInsuranceSubscription
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
        let items: [FinancialProfileItemModel] = (profileModel?.items).unwrappedValue
        return items.compactMap({Double($0.value ?? Constants.ChartValue.defaultAmount)})
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
        let correctExpenseRatio = totalIncome * Constants.ChartValue.expenseRatio
        return !(totalExpense > correctExpenseRatio)
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
        let items: [FinancialProfileItemModel] = (profileModel?.items).unwrappedValue
        var tip = ""
        for each in items {
            tip += "\n" + (each.title.unwrappedValue + " : ₹" + ((each.value ?? Constants.ChartValue.defaultAmount) == "" ? Constants.ChartValue.defaultAmount : (each.value ?? Constants.ChartValue.defaultAmount)))
        }
        return tip
    }
    
}
