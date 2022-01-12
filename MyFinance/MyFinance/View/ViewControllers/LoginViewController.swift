//
//  LoginViewController.swift
//  MyFinance
//
//  Created by Shwetha Surendran on 14/12/21.
//

import UIKit

class LoginViewController: UIViewController {
    
    var loginViewModel: LoginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onClickLogin(_ sender: Any) {
        loginViewModel.signIn(byPresenting: self) {(error) in
            guard error == nil else {return}
            self.navigateToHome()
        }
    }
    
    @IBAction func onSkip(_ sender: Any) {
        navigateToHome()
    }
    
    private func navigateToHome() {
        guard let viewController : HomeViewController = UIStoryboard(name: Constants.Storyboard.main, bundle: nil).instantiateVC() else {return}
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}
