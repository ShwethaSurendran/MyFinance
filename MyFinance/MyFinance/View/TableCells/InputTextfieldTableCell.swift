//
//  InputTextfieldTableCell.swift
//  MyFinance
//
//  Created by Shwetha Surendran on 23/11/21.
//

import UIKit

class InputTextfieldTableCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    var delegate: ProfileDataUpdateProtocol?
    var type: UIType?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setData(title: String, uiType: UIType, isMandatory: Bool) {
        titleLabel.attributedText = isMandatory ? CommonUtility.getAttributedString(fromInputString: (title + "*"), forCharacter: "*") : NSAttributedString.init(string: title)
        inputTextField.keyboardType = uiType == .numberTextField ? .decimalPad : .default
        type = uiType
    }
    
    /// Check if typed value already contains decimal point
    /// - Parameter string: last typed string
    /// - Returns: Boolean value indicating if typed value contains decimal point or not.
    func isDecimalDotExists(string: String)-> Bool {
        let countdots =  (inputTextField.text?.components(separatedBy: (".")).count)! - 1
        if (countdots > 0 && string == ".") {
            return true
        }
        return false
    }
    
}

// MARK: - TextField Delegate methods
extension InputTextfieldTableCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if type == .numberTextField && isDecimalDotExists(string: string) {
            return false
        }
        if let text = textField.text,
           let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange,
                                                       with: string)
            delegate?.updateValue(value: updatedText, index: self.tag)
        }
        return true
    }
}
