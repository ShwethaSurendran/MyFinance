//
//  CommonUtility.swift
//  MyFinance
//
//  Created by Shwetha Surendran on 26/11/21.
//

import Foundation


struct CommonUtility {
    static func getFormattedDate(from date: Date)-> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: date)
    }
}
