//
//  LoginViewModel.swift
//  MyFinance
//
//  Created by Shwetha Surendran on 15/12/21.
//

import GoogleSignIn


protocol GoogleSignInProtocol {
    func signIn(with configuration: GIDConfiguration, presenting presentingViewController: UIViewController, callback: GIDSignInCallback?)
    mutating func signOutCurrentUser()
    var currentLoggedInUser: GIDGoogleUser? { get set }
}

extension GIDSignIn: GoogleSignInProtocol {
    var currentLoggedInUser: GIDGoogleUser? {
        get {
            GIDSignIn.sharedInstance.currentUser
        }
        set {}
    }
    
    func signOutCurrentUser() {
        GIDSignIn.sharedInstance.signOut()
    }
}


protocol LoginProtocol {
    func signIn(byPresenting view: UIViewController, onCompletion: @escaping(Error?) -> Void)
    mutating func signOut()
    func isUserLoggedIn()-> Bool
}


struct LoginViewModel: LoginProtocol {
    
    var googleSignIn: GoogleSignInProtocol?
    
    init(signInDelegate: GoogleSignInProtocol? = GIDSignIn.sharedInstance) {
        googleSignIn = signInDelegate
    }
    
    /// Starts an interactive sign-in flow using the provided configuration.
    /// - Parameters:
    ///   - view: The view controller used to present
    ///   - onCompletion: Called on completion, that passes error response received
    func signIn(byPresenting view: UIViewController, onCompletion: @escaping(Error?) -> Void) {
        let configuration = GIDConfiguration.init(clientID: Constants.GoogleSignIn.clientId)
        googleSignIn?.signIn(with: configuration, presenting: view) { user, error in
            onCompletion(error)
        }
    }
    
    /// Signout current user
    mutating func signOut() {
        googleSignIn?.signOutCurrentUser()
    }
    
    /// Check if user logged in to the app
    /// - Returns: Boolean value indicating if there is user exists or not
    func isUserLoggedIn()-> Bool {
        googleSignIn?.currentLoggedInUser != nil
    }
    
}

