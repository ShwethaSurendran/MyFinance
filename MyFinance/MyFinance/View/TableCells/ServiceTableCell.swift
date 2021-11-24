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
    
    /// Cell ReuseIdentifier
    static var identifier: String {
        return String(describing: self)
    }
    
    func setData(serviceName: String) {
        serviceNameLabel.text = serviceName
    }

}
