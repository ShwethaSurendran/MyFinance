//
//  ReportViewController.swift
//  MyFinance
//
//  Created by Shwetha Surendran on 30/11/21.
//

import UIKit

final class ReportViewController: UIViewController {
    
    @IBOutlet weak var reportTableView: UITableView!
    
    var profileData: [FinancialProfileModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindToViewModel()
    }
    
    /// Bind to updatedProfileData property of viewModel
    /// Update UI, when there is an update in updatedProfileData property
    private func bindToViewModel() {
        var viewModel: ReportViewModel = ReportViewModel.init(existingProfileData: profileData)
        viewModel.updatedProfileData.bind({[weak self] responseModel in
            self?.profileData = responseModel.unwrappedValue
            self?.reportTableView.reloadData()
        })
    }
    
    /// Pops to previous screen on back icon click
    @IBAction func onBackIconClick(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: false)
    }
    
}


// MARK: - TableView DataSource and Delegate methods
extension ReportViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        ///If 'indexPath.section' is not a valid index in ProfileData, then returns '0'
        profileData.isValidIndex(indexPath.section) ? ((profileData[indexPath.section].category == .basicProfile) ?  Constants.ReportTableProperties.basicProfileCellHeight : UITableView.automaticDimension) : 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        profileData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ///If 'section' is not a valid index in ProfileData, then returns '0'
        profileData.isValidIndex(section) ? ((profileData[section].category == .basicProfile) ?  (profileData[section].items?.count).unwrappedValue : Constants.ReportTableProperties.chartSectionRowCount) : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if profileData.isValidIndex(indexPath.section) {
            let profileDataModel: FinancialProfileModel = profileData[indexPath.section]
            switch profileDataModel.category {
            case .basicProfile:
                let cell: ProfileDetailsTableCell = tableView.dequeueReusableCell(for: indexPath)
                if let items = profileDataModel.items, items.isValidIndex(indexPath.row) {
                    cell.setData(item: items[indexPath.row])
                }
                return cell
            default:
                let cell: ChartTableCell = tableView.dequeueReusableCell(for: indexPath)
                cell.setData(model: profileDataModel)
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        profileData.isValidIndex(section) ? profileData[section].category?.rawValue : ""
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as? UITableViewHeaderFooterView
        if let textlabel = header?.textLabel {
            ///Setting section header font size.
            textlabel.font = textlabel.font.withSize(Constants.ReportTableProperties.sectionHeaderFontSize)
        }
    }
    
}
