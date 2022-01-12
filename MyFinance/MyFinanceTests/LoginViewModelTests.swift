//
//  LoginViewModelTests.swift
//  MyFinanceTests
//
//  Created by Shwetha Surendran on 28/12/21.
//

@testable import MyFinance
import XCTest
import GoogleSignIn


class LoginViewModelTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testUserExists() {
        let mockAuthentication = MockGoogleSignIn(currentLoggedInUser: GIDGoogleUser(), error: customError(description: ""))
        let viewModel = LoginViewModel(signInDelegate: mockAuthentication)
        viewModel.signIn(byPresenting: UIViewController()) { error in }
        let isUserLoggedIn = viewModel.isUserLoggedIn()
        XCTAssertTrue(isUserLoggedIn == true, "No valid user exists")
    }
    
    func testNoUserExists() {
        let mockAuthentication = MockGoogleSignIn()
        let viewModel = LoginViewModel(signInDelegate: mockAuthentication)
        viewModel.signIn(byPresenting: UIViewController()) { error in }
        let isUserLoggedIn = viewModel.isUserLoggedIn()
        XCTAssertTrue(isUserLoggedIn == false, "Valid user exists")
    }
    
    func testSignout() {
        let mockAuthentication = MockGoogleSignIn(currentLoggedInUser: GIDGoogleUser(), error: customError(description: ""))
        var viewModel = LoginViewModel(signInDelegate: mockAuthentication)
        viewModel.signIn(byPresenting: UIViewController()) { error in }
        let isUserLoggedIn = viewModel.isUserLoggedIn()
        XCTAssertTrue(isUserLoggedIn == true, "No valid user exists")
        viewModel.signOut()
        let isUserLoggedInAfterSignOut = viewModel.isUserLoggedIn()
        XCTAssertTrue(isUserLoggedInAfterSignOut == false, "Valid user exists")
    }
    
}


struct MockGoogleSignIn: GoogleSignInProtocol {

    var currentLoggedInUser: GIDGoogleUser?
    var error: Error?

    func signIn(with configuration: GIDConfiguration, presenting presentingViewController: UIViewController, callback: GIDSignInCallback?) {
        callback?(currentLoggedInUser, error)
    }

    mutating func signOutCurrentUser() {
        currentLoggedInUser = nil
    }

}


struct customError: Error {
    var description: String
}
