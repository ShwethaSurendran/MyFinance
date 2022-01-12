//
//  BasicProfileViewController.swift
//  MyFinance
//
//  Created by Shwetha Surendran on 22/11/21.
//

import UIKit

final class FinancialProfileViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var profileDetailsTableview: UITableView!
    
    var profileData: [FinancialProfileModel] = []
    private var screenIndex = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ///If profileData is empty, then bind to viewModel for getting profile Details. Else, update UI from existing ProfileData
        profileData.isEmpty ? bindToViewModel() : setupData()
    }
    
    /// setup UI data
    private func setupData() {
        if profileData.isValidIndex(screenIndex) {
            titleLabel.text = profileData[screenIndex].category?.rawValue
            //            profileDetailsTableview.reloadData()
        }
    }
    
    /// Bind to profileData property of viewModel
    /// Update UI, when there is an update in profileData property
    private func bindToViewModel() {
        var viewModel: FinancialProfileViewModel = FinancialProfileViewModel(fileNameToLoadDataFrom: Constants.JsonFileNames.financePlannerCategories, jsonParser: JSONParser())
        viewModel.profileData.bind({[weak self] responseModel in
            self?.profileData = responseModel.unwrappedValue
            self?.setupData()
        })
    }
    
    @IBAction func onClickSubmit(_ sender: Any) {
        ///On submit, Check if mandatory fields are filled
        if profileData.isValidIndex(screenIndex),!isMandatoryFieldsAreEmpty(financialProfileModel: profileData[screenIndex]) {
            
            ///save current screen details to store
            saveProfileData()
            
            if profileData.isValidIndex(screenIndex+1) {
                ///Navigates to new screen by passing index of next details to be shown
                navigateToNextProfileCategoryScreen()
            }else {
                /// If current screen is the last screen for submitting Profle details, then navigates to Report screen
                navigateToReportScreen()
            }
        }else {
            ///Show alert asking to fill mandatory fields
            showAlert(title: "", message: Constants.AlertMessage.mandatoryFieldAlert, actionHandler: {})
        }
    }
    
    ///save current screen details to store only if user logged in
    private func saveProfileData() {
        if LoginViewModel().isUserLoggedIn() {
            let userViewModel = UserViewModel()
            let loggedInUserData = userViewModel.getLoggedInUserDetails()
            userViewModel.save(profileData: profileData[screenIndex], to: CoreDataManager(), forUser: loggedInUserData.email.unwrappedValue)
        }
    }
    
    ///Navigate to next profile category screen
    private func navigateToNextProfileCategoryScreen() {
        guard let viewController : FinancialProfileViewController = UIStoryboard(name: Constants.Storyboard.main, bundle: nil).instantiateVC() else {return}
        viewController.screenIndex = screenIndex+1
        viewController.profileData = profileData
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    //Navigate to Financial Report screen
    private func navigateToReportScreen() {
        guard let viewController : ReportViewController = UIStoryboard(name: Constants.Storyboard.main, bundle: nil).instantiateVC() else {return}
        viewController.profileData = profileData
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    /// Check 'isMandatory' key of each profile detail and check if its value is empty
    /// - Parameter financialProfileModel: Profile Details shown in currently viewing screen
    /// - Returns: Boolean value indicating if mandatory fields are empty
    func isMandatoryFieldsAreEmpty(financialProfileModel: FinancialProfileModel)-> Bool {
        guard let items = financialProfileModel.items else {return false}
        for each in items {
            if (each.isMandatory.unwrappedValue), (each.value.unwrappedValue.isEmpty) {
                return true
            }
        }
        return false
    }
    
    /// Pops to previous screen on back icon click
    @IBAction func onBackIconClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}


// MARK: - TableView DataSource and Delegate methods
extension FinancialProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        profileData.isValidIndex(screenIndex) ? (profileData[screenIndex].items?.count).unwrappedValue : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if profileData.isValidIndex(screenIndex), let items = profileData[screenIndex].items, items.isValidIndex(indexPath.row) {
            let currentItem = items[indexPath.row]
            
            switch currentItem.type {
            case .picker:
                let cell: PickerTableCell = tableView.dequeueReusableCell(for: indexPath)
                cell.setData(title: currentItem.title.unwrappedValue, pickerOptions: currentItem.options.unwrappedValue, isMandatory: currentItem.isMandatory.unwrappedValue)
                cell.delegate = self
                return cell
            case .datePicker:
                let cell: DatePickerTableCell = tableView.dequeueReusableCell(for: indexPath)
                cell.setData(title: currentItem.title.unwrappedValue, isMandatory: currentItem.isMandatory.unwrappedValue)
                cell.delegate = self
                return cell
            default:
                let cell: InputTextfieldTableCell = tableView.dequeueReusableCell(for: indexPath)
                cell.setData(financialProfileItem: currentItem)
                cell.delegate = self
                return cell
            }
        }
        return UITableViewCell()
    }
    
}


// MARK: - Update profileData variable, when user add/update profile details
extension FinancialProfileViewController: ProfileDataUpdateProtocol {
    func updateValue(value: String, index: Int) {
        if profileData.isValidIndex(screenIndex), let items = profileData[screenIndex].items, items.isValidIndex(index) {
            profileData[screenIndex].items?[index].value = value
        }
    }
}

