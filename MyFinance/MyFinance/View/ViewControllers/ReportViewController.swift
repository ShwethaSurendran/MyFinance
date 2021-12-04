//
//  ReportViewController.swift
//  MyFinance
//
//  Created by Shwetha Surendran on 30/11/21.
//

import UIKit

class ReportViewController: UIViewController {
    
    @IBOutlet weak var reportTableView: UITableView!
    
    var profileData: [FinancialProfileModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    func initialSetup() {
        reportTableView.estimatedRowHeight = 100
        bindToViewModel()
    }
    
    /// Bind to updatedProfileData property of viewModel
    /// Update UI, when there is an update in updatedProfileData property
    func bindToViewModel() {
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
        (profileData[indexPath.section].category == .basicProfile) ?  40 : UITableView.automaticDimension
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        profileData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (profileData[section].category == .basicProfile) ?  (profileData[section].items?.count).unwrappedValue : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if profileData[indexPath.section].category == .basicProfile {
            let cell: ProfileDetailsTableCell = tableView.dequeueReusableCell(for: indexPath)
            if indexPath.section < profileData.count {
                let profileDataModel: FinancialProfileModel = profileData[indexPath.section]
                if let items = profileDataModel.items, indexPath.row < items.count {
                    cell.setData(item: items[indexPath.row])
                }
            }
            return cell
        }else {
            let cell: ChartTableCell = tableView.dequeueReusableCell(for: indexPath)
            cell.setData(model: profileData[indexPath.section])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        profileData[section].category?.rawValue
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        let header = view as! UITableViewHeaderFooterView
        
        if let textlabel = header.textLabel {
            textlabel.font = textlabel.font.withSize(23)
        }
    }
    
}
