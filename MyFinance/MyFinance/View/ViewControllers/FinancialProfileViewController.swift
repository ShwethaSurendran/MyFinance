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
    var currentOption: Constants.FinancialService = .financePlanner
    
    
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
        var viewModel: FinancialProfileViewModel = FinancialProfileViewModel(fileNameToLoadDataFrom: currentOption == .financePlanner ? Constants.JsonFileNames.financePlannerCategories : Constants.JsonFileNames.wealthCreationCategories)
        viewModel.profileData.bind({[weak self] responseModel in
            self?.profileData = responseModel ?? []
            self?.setupData()
        })
    }
    
    /// On submit, navigates to new screen by passing index of next details to be shown
    @IBAction func onClickSubmit(_ sender: Any) {
        if screenIndex+1 < profileData.count {
            guard let viewController : FinancialProfileViewController = UIStoryboard(name: Constants.Storyboard.main, bundle: nil).instantiateVC() else {return}
            viewController.screenIndex = screenIndex+1
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
//        showAlert(title: "", message: "You will lost all entered data when you go back. Do you still want to continue?") {
            self.navigationController?.popViewController(animated: true)
//        }
    }
    
}

// MARK: - TableView DataSource and Delegate methods
extension FinancialProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        (screenIndex < profileData.count) ? (profileData[screenIndex].items?.count ?? 0) : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let currentItem = profileData[screenIndex].items?[indexPath.row] else {return UITableViewCell()}
        if currentItem.type == .picker {
            let cell: PickerTableCell = tableView.dequeueReusableCell(for: indexPath)
            cell.setData(title: currentItem.title ?? "", pickerOptions: currentItem.options ?? [])
            cell.delegate = self
            return cell
        }else if currentItem.type == .datePicker {
            let cell: DatePickerTableCell = tableView.dequeueReusableCell(for: indexPath)
            cell.setData(title: currentItem.title ?? "")
            profileData[screenIndex].items?[indexPath.row]?.value = CommonUtility.getFormattedDate(from: Date())
            cell.delegate = self
            return cell
        }else {
            let cell: InputTextfieldTableCell = tableView.dequeueReusableCell(for: indexPath)
            cell.setData(title: currentItem.title ?? "", uiType: currentItem.type ?? .stringTextField)
            cell.delegate = self
            return cell
        }
        
    }
    
}


// MARK: - Update profileData variable, when user add/update profile details
extension FinancialProfileViewController: ProfileDataUpdateProtocol {
    func updateValue(value: String, index: Int) {
        profileData[screenIndex].items?[index]?.value = value
    }
}

