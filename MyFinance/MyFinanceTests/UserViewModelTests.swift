//
//  UserViewModelTests.swift
//  MyFinanceTests
//
//  Created by Shwetha Surendran on 22/12/21.
//

@testable import MyFinance
import XCTest
import GoogleSignIn

class UserViewModelTests: XCTestCase {
    
    var userViewModel:UserViewModel?


    override func setUpWithError() throws {
        userViewModel = UserViewModel()
    }

    override func tearDownWithError() throws {
        userViewModel = nil
    }
    
    func testValidDataInDatabase() {
        let profileModel = FinancialProfileModel(category: .assets, items: [], tip: "", index: 0)
        let database = MockDatabase.init(profileData: profileModel)
        userViewModel?.save(profileData: profileModel, to: database, forUser: "test")
        let savedData = (userViewModel?.getExistingProfileData(from: database, forUser: "test")).unwrappedValue
        XCTAssertTrue(!savedData.isEmpty, "There is no data saved in database")
    }
    
    func testEmptyDataInDatabase() {
        let database = MockDatabase.init(profileData: nil)
        let savedData = userViewModel?.getExistingProfileData(from: database, forUser: "test")
        XCTAssertTrue(savedData == nil, "There is no data saved in database")
    }
    
    func testLoggedInUserDetails() {
        let mockAuthentication = MockGoogleSignIn(currentLoggedInUser: GIDGoogleUser(), error: customError(description: ""))
        let currentUser = userViewModel?.getLoggedInUserDetails(googleSignIn: mockAuthentication)
        XCTAssertTrue(currentUser != nil)
    }
    
    func testMandatoryFieldHasValue() {
        let profileModel = FinancialProfileModel.init(category: .income, items: [FinancialProfileItemModel(title: "FirstName", type: nil, options: nil, value: "John", isMandatory: true)], tip: "", index: nil)
        let hasValue = userViewModel?.isMandatoryFieldHasValue(profileData: [profileModel])
        XCTAssertTrue(hasValue == true, "Mandatory field is empty")
    }
    
    func testMandatoryFieldHasNoValue() {
        let profileModel = FinancialProfileModel.init(category: .income, items: [FinancialProfileItemModel(title: "FirstName", type: nil, options: nil, value: "", isMandatory: true)], tip: "", index: nil)
        let hasValue = userViewModel?.isMandatoryFieldHasValue(profileData: [profileModel])
        XCTAssertTrue(hasValue == false, "Mandatory field is not empty")
    }


}



struct MockDatabase: DatabaseProtocol {
    
    var profileData: FinancialProfileModel?
    
    mutating func save(userProfileDetails model: FinancialProfileModel, forUser emailId: String) {
    }
    
    mutating func getUserProfileDetails(withEmail emailId: String) -> [FinancialProfileModel]? {
        return profileData == nil ? nil : [profileData!]
    }
    
}
