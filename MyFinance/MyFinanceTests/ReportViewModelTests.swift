//
//  ReportViewModelTests.swift
//  MyFinanceTests
//
//  Created by Shwetha Surendran on 03/12/21.
//

@testable import MyFinance
import XCTest

class ReportViewModelTests: XCTestCase {
    
    var reportViewModel: ReportViewModel?
    let testProfileModel = [FinancialProfileModel.init(category: .income, items: [FinancialProfileItemModel(title: nil, type: nil, options: nil, value: "5", isMandatory: nil), FinancialProfileItemModel(title: nil, type: nil, options: nil, value: "5", isMandatory: nil)], tip: nil)]

    
    override func setUpWithError() throws {
        reportViewModel = ReportViewModel(existingProfileData: [])
    }
    
    override func tearDownWithError() throws {
        reportViewModel = nil
    }
    
    func testHasUpdatedProfileData() {
        let viewModel = ReportViewModel.init(existingProfileData: testProfileModel)
        XCTAssertTrue(((viewModel.updatedProfileData.value?.count).unwrappedValue) > 1, "Updated ProfileData is empty")
    }
    
    func testUpdatedProfileDataEmpty() {
        let viewModel = ReportViewModel.init(existingProfileData: [])
        XCTAssertTrue(((viewModel.updatedProfileData.value?.count).unwrappedValue) == 1, "Updated ProfileData is not empty")
    }
    
    func testTotalAmountCalculation() {
        let total = reportViewModel?.getTotalAmount(forCategory: .income, from: testProfileModel)
        XCTAssertEqual(total, 10, "Incorrect Total amount calculation")
    }
    
    func testDivisionsForCategory() {
        let divisions = reportViewModel?.getDivisions(forCategory: .income, from: testProfileModel)
        XCTAssertEqual(divisions, [5, 5], "Invalid divisions")
    }
    
    func testIncomeIsGood() {
        let isGoodIncome = reportViewModel?.isGoodIncomeOrAssetAllocation(forProfileDetails: testProfileModel, category: .income)
        XCTAssertTrue(isGoodIncome == true, "There is no multiple ways for income")
    }
    
    func testIncomeIsNotGood() {
        let profileModel = [FinancialProfileModel.init(category: .income, items: [FinancialProfileItemModel(title: nil, type: nil, options: nil, value: "5", isMandatory: nil)], tip: nil)]
        let isGoodIncome = reportViewModel?.isGoodIncomeOrAssetAllocation(forProfileDetails: profileModel, category: .income)
        XCTAssertTrue(isGoodIncome == false, "There are multiple ways for income")
    }
    
    func testAssetAllocationIsGood() {
        let profileModel = [FinancialProfileModel.init(category: .assets, items: [FinancialProfileItemModel(title: nil, type: nil, options: nil, value: "5", isMandatory: nil), FinancialProfileItemModel(title: nil, type: nil, options: nil, value: "5", isMandatory: nil)], tip: nil)]
        let isGoodAssetAllocation = reportViewModel?.isGoodIncomeOrAssetAllocation(forProfileDetails: profileModel, category: .assets)
        XCTAssertTrue(isGoodAssetAllocation == true, "There is single or no asset allocations")
    }
    
    func testAssetAllocationIsNotGood() {
        let profileModel = [FinancialProfileModel.init(category: .assets, items: [FinancialProfileItemModel(title: nil, type: nil, options: nil, value: "5", isMandatory: nil)], tip: nil)]
        let isGoodAssetAllocation = reportViewModel?.isGoodIncomeOrAssetAllocation(forProfileDetails: profileModel, category: .assets)
        XCTAssertTrue(isGoodAssetAllocation == false, "There are multiple asset allocations")
    }
    
    func testExpenseRatioIsGood() {
        let incomeModel = FinancialProfileModel.init(category: .income, items: [FinancialProfileItemModel(title: nil, type: nil, options: nil, value: "10", isMandatory: nil)], tip: nil)
        let expenseModel = FinancialProfileModel.init(category: .expenses, items: [FinancialProfileItemModel(title: nil, type: nil, options: nil, value: "5", isMandatory: nil)], tip: nil)
        let isGoodExpenseRatio = reportViewModel?.isGoodExpenseRatio(forProfileDetails: [incomeModel, expenseModel])
        XCTAssertTrue(isGoodExpenseRatio == true, "Total Expense is greater than 50% of Total Income")
    }
    
    func testExpenseRatioIsNotGood() {
        let incomeModel = FinancialProfileModel.init(category: .income, items: [FinancialProfileItemModel(title: nil, type: nil, options: nil, value: "10", isMandatory: nil)], tip: nil)
        let expenseModel = FinancialProfileModel.init(category: .expenses, items: [FinancialProfileItemModel(title: nil, type: nil, options: nil, value: "6", isMandatory: true)], tip: nil)
        let isGoodExpenseRatio = reportViewModel?.isGoodExpenseRatio(forProfileDetails: [incomeModel, expenseModel])
        XCTAssertTrue(isGoodExpenseRatio == false, "Total Expense is less than or equal to 50% of Total Income")
    }
    
    func testTotalNetworth() {
        let assetsModel = FinancialProfileModel.init(category: .assets, items: [FinancialProfileItemModel(title: nil, type: nil, options: nil, value: "10", isMandatory: nil)], tip: nil)
        let liabilitiesModel = FinancialProfileModel.init(category: .liabilities, items: [FinancialProfileItemModel(title: nil, type: nil, options: nil, value: "5", isMandatory: true)], tip: nil)
        let totalNetworth = reportViewModel?.getTotalNetWorth(forProfileDetails: [assetsModel, liabilitiesModel])
        XCTAssertEqual(totalNetworth, 5, "Incorrect Total Networth calculation")
    }
    
    func testInsuranceSubscriptionIsGood() {
        let profileModel = [FinancialProfileModel.init(category: .insurance, items: [FinancialProfileItemModel(title: nil, type: nil, options: nil, value: "5", isMandatory: nil)], tip: nil)]
        let isGoodInsuranceSubscription = reportViewModel?.isGoodInsuranceSubscription(forProfileDetails: profileModel)
        XCTAssertTrue(isGoodInsuranceSubscription == true, "Not subscribed for any insurance")
    }
    
    func testInsuranceSubscriptionIsNotGood() {
        let profileModel = [FinancialProfileModel.init(category: .insurance, items: [], tip: nil)]
        let isGoodInsuranceSubscription = reportViewModel?.isGoodInsuranceSubscription(forProfileDetails: profileModel)
        XCTAssertTrue(isGoodInsuranceSubscription == false, "Subscribed for insurance")
    }
    
}
