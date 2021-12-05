//
//  HomeViewController.swift
//  MyFinance
//
//  Created by Shwetha Surendran on 22/11/21.
//

import UIKit

final class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

// MARK: - TableView DataSource and Delegate methods
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.FinancialService.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ServiceTableCell = tableView.dequeueReusableCell(for: indexPath)
        Constants.FinancialService.allCases.isValidIndex(indexPath.row) ?
            cell.setData(serviceName: Constants.FinancialService.allCases[indexPath.row].rawValue): nil
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewController : FinancialProfileViewController = UIStoryboard(name: Constants.Storyboard.main, bundle: nil).instantiateVC() else {return}
        Constants.FinancialService.allCases.isValidIndex(indexPath.row) ? viewController.currentOption = Constants.FinancialService.allCases[indexPath.row] : nil
        navigationController?.pushViewController(viewController, animated: false)
    }
    
}




