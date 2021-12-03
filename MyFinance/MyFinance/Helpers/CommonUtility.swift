//
//  CommonUtility.swift
//  MyFinance
//
//  Created by Shwetha Surendran on 26/11/21.
//

import UIKit


struct CommonUtility {
    static func getFormattedDate(from date: Date)-> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: date)
    }
    
    static func getAttributedString(fromInputString string: String, forCharacter character: String)-> NSAttributedString {
        let attributedString = NSMutableAttributedString.init(string:string)
        let range = NSString(string: string).range(of: character, options: String.CompareOptions.caseInsensitive)
        attributedString.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.red], range: range)
        return attributedString
    }
}
