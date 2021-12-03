//
//  ProfileDetailsTableCell.swift
//  MyFinance
//
//  Created by Shwetha Surendran on 30/11/21.
//

import UIKit

class ProfileDetailsTableCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setData(item: FinancialProfileItemModel?) {
        titleLabel.text = item?.title
        valueLabel.text = item?.value == "" ? "--" : item?.value
    }

}
