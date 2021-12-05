//
//  ServiceTableCell.swift
//  MyFinance
//
//  Created by Shwetha Surendran on 22/11/21.
//

import UIKit

class ServiceTableCell: UITableViewCell {
    
    @IBOutlet weak var serviceNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setData(serviceName: String) {
        serviceNameLabel.text = serviceName
    }
    
}
