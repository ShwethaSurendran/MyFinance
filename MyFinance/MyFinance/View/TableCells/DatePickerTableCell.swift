//
//  DatePickerTableCell.swift
//  MyFinance
//
//  Created by Shwetha Surendran on 26/11/21.
//

import UIKit

class DatePickerTableCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    var delegate: ProfileDataUpdateProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setData(title: String, isMandatory: Bool) {
        titleLabel.attributedText = CommonUtility.getMandatoryFieldTitle(isMandatory: isMandatory, title: title)
    }
    
    /// Calls this method when picking date from DatePicker
    @IBAction func onPickDate(_ sender: Any) {
        delegate?.updateValue(value: CommonUtility.getFormattedDate(from: datePicker.date), index: self.tag)
    }
    
}
