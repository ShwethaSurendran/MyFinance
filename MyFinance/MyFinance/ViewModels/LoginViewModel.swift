//
//  LoginViewModel.swift
//  MyFinance
//
//  Created by Shwetha Surendran on 15/12/21.
//

import GoogleSignIn

protocol LoginProtocol {
    func signIn(byPresenting view: UIViewController, onCompletion: @escaping(Error?) -> Void)
    func signOut()
    func isUserLoggedIn()-> Bool
}


struct LoginViewModel: LoginProtocol {
    
    /// Starts an interactive sign-in flow using the provided configuration.
    /// - Parameters:
    ///   - view: The view controller used to present
    ///   - onCompletion: Called on completion, that passes error response received
    func signIn(byPresenting view: UIViewController, onCompletion: @escaping(Error?) -> Void) {
        let configuration = GIDConfiguration.init(clientID: Constants.GoogleSignIn.clientId)
        GIDSignIn.sharedInstance.signIn(with: configuration, presenting: view) { user, error in
            onCompletion(error)
        }
    }
    
    /// Signout current user
    func signOut() {
        GIDSignIn.sharedInstance.signOut()
    }
    
    /// Check if user logged in to the app
    /// - Returns: Boolean value indicating if there is user exists or not
    func isUserLoggedIn()-> Bool {
        GIDSignIn.sharedInstance.currentUser != nil
    }
    
}
