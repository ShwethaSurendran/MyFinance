//
//  FinancePlannerModel.swift
//  MyFinance
//
//  Created by Shwetha Surendran on 23/11/21.
//

import Foundation

struct FinancialProfileModel: Decodable {
    var category: String?
    var items: [FinancialProfileItemModel?]?
}

struct FinancialProfileItemModel: Decodable {
    var title: String?
    var type: UIType?
    var options: [String]?
    var value: String?
}

enum UIType: String, Decodable {
    case stringTextField
    case numberTextField
    case picker
    case datePicker
}
