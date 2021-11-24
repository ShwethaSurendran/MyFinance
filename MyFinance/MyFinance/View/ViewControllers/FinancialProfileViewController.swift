//
//  BasicProfileViewController.swift
//  MyFinance
//
//  Created by Shwetha Surendran on 22/11/21.
//

import UIKit

class FinancialProfileViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var profileDetailsTableview: UITableView!
    
    var profileData: [FinancialProfileModel] = []
    var screenIndex = 0
    var currentOption: Constants.FinancialServices = .financePlanner
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileData.isEmpty ? bindToViewModel() : setupData()
    }
    
    /// setup UI data
    func setupData() {
        if profileData.count > 0 {
            titleLabel.text = profileData[screenIndex].category
            profileDetailsTableview.reloadData()
        }
    }
    
    /// Bind to profileData property of viewModel
    /// Update UI, when there is an update in profileData property
    func bindToViewModel() {
        var viewModel: FinancialProfileViewModel = FinancialProfileViewModel()
        viewModel.profileData.bind({ responseModel in
            self.profileData = responseModel ?? []
            self.setupData()
        })
        viewModel.getProfileData(fromJSONFile: currentOption == .financePlanner ? Constants.JsonFileNames.financePlannerCategories : Constants.JsonFileNames.wealthCreationCategories)
    }
    
    
    /// On submit, navigates to new screen by passing index of next details to be shown
    @IBAction func onClickSubmit(_ sender: Any) {
        screenIndex += 1
        if screenIndex < profileData.count {
            guard let viewController : FinancialProfileViewController = UIStoryboard(name: Constants.Storyboard.main, bundle: nil).instantiateVC() else {return}
            viewController.screenIndex = screenIndex
            viewController.profileData = profileData
            navigationController?.pushViewController(viewController, animated: true)
        }else {
            showAlert(title: "", message: "Make sure all data entered is valid before generating report") {
                self.navigationController?.popToRootViewController(animated: false)
            }
        }
    }
    
    
    /// Pops to previous screen on back icon click
    @IBAction func onBackIconClick(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

}

// MARK: - TableView DataSource and Delegate methods
extension FinancialProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        (screenIndex < profileData.count) ? (profileData[screenIndex].items?.count ?? 0) : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: InputTextfieldTableCell = tableView.dequeueReusableCell(withIdentifier: InputTextfieldTableCell.identifier, for: indexPath) as! InputTextfieldTableCell
        cell.tag = indexPath.row
        cell.setData(title: screenIndex < profileData.count ? profileData[screenIndex].items?[indexPath.row].title ?? "" : "")
        cell.delegate = self
        return cell
    }
    
}


// MARK: - Update profileData variable, when user add/update profile details
extension FinancialProfileViewController: ProfileDataUpdateProtocol {
    func updateValue(value: String, index: Int) {
        profileData[screenIndex].items?[index].value = value
    }
}

