//
//  CommonUtility.swift
//  MyFinance
//
//  Created by Shwetha Surendran on 26/11/21.
//

import UIKit


struct CommonUtility {
    /// Convert 'date' property to string using specified format
    /// - Parameter date: Date to convert
    /// - Returns: Date in string format
    static func getFormattedDate(from date: Date, format: String = Constants.DateFormat.dateMonthYear)-> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
    
    
    /// Generates an attributed string from the 'String' property by applying attributes to 'character' part of the string
    /// - Parameters:
    ///   - string: String to convert to attributed string
    ///   - character: String to apply specified attributes
    ///   - color: UIColor property to apply for 'character' string
    /// - Returns: NSAttributedString generated by applying specified attributes
    static func getAttributedString(fromInputString string: String, forCharacter character: String, color: UIColor)-> NSAttributedString {
        let attributedString = NSMutableAttributedString.init(string:string)
        let range = NSString(string: string).range(of: character, options: String.CompareOptions.caseInsensitive)
        attributedString.addAttributes([NSAttributedString.Key.foregroundColor : color], range: range)
        return attributedString
    }
    
    /// Generates attributed string based on 'isMandatory' key
    /// - Parameters:
    ///   - isMandatory: Bool indicating that field is mandatory
    ///   - title: Title from which to generate attributed string
    /// - Returns: NSAttributedString generated based on 'isMandatory' key
    static func getMandatoryFieldTitle(isMandatory: Bool, title: String)-> NSAttributedString {
        let title = isMandatory ? getAttributedString(fromInputString: (title + Constants.asteriskString), forCharacter: Constants.asteriskString, color: .red) : NSAttributedString.init(string: title)
        return title
    }
}
