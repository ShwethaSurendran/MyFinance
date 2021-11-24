//
//  InputTextfieldTableCell.swift
//  MyFinance
//
//  Created by Shwetha Surendran on 23/11/21.
//


protocol ProfileDataUpdateProtocol {
    func updateValue(value: String, index: Int)
}


import UIKit

class InputTextfieldTableCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    var delegate: ProfileDataUpdateProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    /// Cell ReuseIdentifier
    static var identifier: String {
        return String(describing: self)
    }
    
    func setData(title: String) {
        titleLabel.text = title
    }
    
}

// MARK: - TextField Delegate methods
extension InputTextfieldTableCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text,
           let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange,
                                                       with: string)
            delegate?.updateValue(value: updatedText, index: self.tag)
        }
        return true
    }
}
