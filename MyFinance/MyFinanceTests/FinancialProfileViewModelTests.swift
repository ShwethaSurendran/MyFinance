//
//  FinancialProfileViewModelTests.swift
//  MyFinanceTests
//
//  Created by Shwetha Surendran on 03/12/21.
//

@testable import MyFinance
import XCTest

class FinancialProfileViewModelTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }
    
    func testHasProfileData() {
        let testProfileModel = [FinancialProfileModel.init(category: .income, items: [FinancialProfileItemModel(title: nil, type: nil, options: nil, value: "5", isMandatory: nil), FinancialProfileItemModel(title: nil, type: nil, options: nil, value: "5", isMandatory: nil)], tip: "", index: nil)]
        let viewModel = FinancialProfileViewModel.init(fileNameToLoadDataFrom: "", jsonParser: MockJsonParser(testProfileModel: testProfileModel))
        XCTAssertTrue((viewModel.profileData.value?.count).unwrappedValue > 0, "ProfileData is empty")
    }
    
    func testProfileDataEmpty() {
        let viewModel = FinancialProfileViewModel.init(fileNameToLoadDataFrom: "", jsonParser: MockJsonParser(testProfileModel: []))
        XCTAssertTrue(((viewModel.profileData.value?.count).unwrappedValue) == 0, "ProfileData is not empty")
    }
    
    func testProfileDataHasDefaultValue() {
        let viewModel = FinancialProfileViewModel.init()
        let testProfileModel = [FinancialProfileModel.init(category: .income, items: [FinancialProfileItemModel(title: nil, type: .datePicker, options: nil, value: "", isMandatory: nil)], tip: "", index: nil)]
        let updatedProfileData = viewModel.getUpdatedProfileData(from: testProfileModel)
        let items = updatedProfileData.first?.items
        let values = items?.compactMap({$0.value})
        let hasValue = values?.allSatisfy({!$0.isEmpty})
        XCTAssertEqual(hasValue, true, "Datepicker type has no default value")
    }
    
    func testProfileDataHasNoDefaultValue() {
         let viewModel = FinancialProfileViewModel.init()
         let testProfileModel = [FinancialProfileModel.init(category: .income, items: [FinancialProfileItemModel(title: nil, type: .stringTextField, options: nil, value: "", isMandatory: nil)], tip: "", index: nil)]
         let updatedProfileData = viewModel.getUpdatedProfileData(from: testProfileModel)
         let items = updatedProfileData.first?.items
         let values = items?.compactMap({$0.value})
         let hasValue = values?.allSatisfy({!$0.isEmpty})
         XCTAssertEqual(hasValue, false, "Datepicker type has default value")
     }

}


struct MockJsonParser: JSONParserProtocol {
    
    var testProfileModel: [FinancialProfileModel]

    func decodeJSON<T>(from fileName: String) -> T? where T : Decodable {
        return testProfileModel as? T
    }
    
}
