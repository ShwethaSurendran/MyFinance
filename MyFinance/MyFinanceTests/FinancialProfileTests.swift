//
//  FinancialProfileTests.swift
//  MyFinanceTests
//
//  Created by Shwetha Surendran on 03/12/21.
//

@testable import MyFinance
import XCTest

class FinancialProfileTests: XCTestCase {
    
    var financialProfileViewController: FinancialProfileViewController?
    
    override func setUpWithError() throws {
        financialProfileViewController = FinancialProfileViewController()
    }
    
    override func tearDownWithError() throws {
        financialProfileViewController = nil
    }
    
    func testMandatoryFieldIsEmpty() {
        let profileModel = FinancialProfileModel.init(category: .income, items: [FinancialProfileItemModel(title: nil, type: nil, options: nil, value: nil, isMandatory: true)], tip: "", index: nil)
        let isEmpty = financialProfileViewController?.isMandatoryFieldsAreEmpty(financialProfileModel: profileModel)
        XCTAssertTrue(isEmpty == true, "Mandatory field is not empty")
    }
    
    func testMandatoryFieldIsNotEmpty() {
        let profileModel = FinancialProfileModel.init(category: .income, items: [FinancialProfileItemModel(title: nil, type: nil, options: nil, value: "Test Value", isMandatory: true)], tip: "", index: nil)
        let isEmpty = financialProfileViewController?.isMandatoryFieldsAreEmpty(financialProfileModel: profileModel)
        XCTAssertTrue(isEmpty == false, "Mandatory field is empty")
    }
    
}
