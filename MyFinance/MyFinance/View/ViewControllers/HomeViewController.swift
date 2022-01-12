//
//  HomeViewController.swift
//  MyFinance
//
//  Created by Shwetha Surendran on 22/11/21.
//

import UIKit

final class HomeViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var userDetailsStack: UIStackView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    private var profileData: [FinancialProfileModel] = []
    private var options: [Constants.FinancialServiceOption] = [.generateReport]
    private var loginViewModel = LoginViewModel()
    private let userViewModel = UserViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
    }
    
    private func setupUI() {
        let isUserLoggedIn = loginViewModel.isUserLoggedIn()
        userDetailsStack.isHidden = isUserLoggedIn ? false : true
        backButton.isHidden = isUserLoggedIn ? true : false
        isUserLoggedIn ? setupUserDetails() : nil
    }
    
    private func setupUserDetails() {
        let userData = userViewModel.getLoggedInUserDetails()
        nameLabel.text = userData.name
        emailLabel.text = userData.email
        getExistingProfileData(forUser: userData.email.unwrappedValue)
    }
    
    private func getExistingProfileData(forUser emailId: String) {
        guard let existingProfileData = userViewModel.getExistingProfileData(from: CoreDataManager(), forUser: emailId) else {
            return
        }
        
        profileData = existingProfileData
        !options.contains(.yourReport) ? options.append(.yourReport) : nil
        tableView.reloadData()
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onClickLogout(_ sender: Any) {
        loginViewModel.signOut()
        setLoginRootViewController()
    }
    
    private func setLoginRootViewController() {
        guard let viewController : LoginViewController = UIStoryboard(name: Constants.Storyboard.main, bundle: nil).instantiateVC() else {return}
        let navigationController = CustomNavigation.init(rootView: viewController)
        self.view.window?.rootViewController = navigationController
        self.view.window?.makeKeyAndVisible()
    }
    
}


// MARK: - TableView DataSource and Delegate methods
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ServiceTableCell = tableView.dequeueReusableCell(for: indexPath)
        options.isValidIndex(indexPath.row) ?
            cell.setData(serviceName: options[indexPath.row].rawValue): nil
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedOption: Constants.FinancialServiceOption? = options.isValidIndex(indexPath.row) ? options[indexPath.row] : nil
        
        switch selectedOption {
        
        case .generateReport:
            guard let viewController : FinancialProfileViewController = UIStoryboard(name: Constants.Storyboard.main, bundle: nil).instantiateVC() else {return}
            navigationController?.pushViewController(viewController, animated: true)
            
        case .yourReport:
            guard let viewController : ReportViewController = UIStoryboard(name: Constants.Storyboard.main, bundle: nil).instantiateVC() else {return}
            viewController.profileData = self.profileData
            navigationController?.pushViewController(viewController, animated: true)
            
        default: break
            
        }
        
    }
    
}




