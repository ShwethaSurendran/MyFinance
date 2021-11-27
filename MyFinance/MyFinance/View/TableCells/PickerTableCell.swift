//
//  PickerTableCell.swift
//  MyFinance
//
//  Created by Shwetha Surendran on 26/11/21.
//

import UIKit

class PickerTableCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var selectedItemButton: UIButton!
    @IBOutlet weak var picker: UIPickerView!
    var delegate: ProfileDataUpdateProtocol?
    var options: [String] = []

    
    override func awakeFromNib() {
        super.awakeFromNib()
        picker.isHidden = true
        selectedItemButton.isHidden = false
    }
    
    func setData(title: String, pickerOptions: [String]) {
        titleLabel.text = title
        options = pickerOptions
    }
    
    @IBAction func onTapView(_ sender: Any) {
        picker.isHidden = false
        selectedItemButton.isHidden = true
    }
}


extension PickerTableCell: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        options.count
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedItemButton.setTitle(options[row], for: .normal)
        delegate?.updateValue(value: options[row], index: self.tag)
        picker.isHidden = true
        selectedItemButton.isHidden = false
    }
        
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: options[row], attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
    }

}
