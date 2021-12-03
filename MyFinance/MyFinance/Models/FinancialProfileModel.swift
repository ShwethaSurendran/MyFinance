//
//  FinancePlannerModel.swift
//  MyFinance
//
//  Created by Shwetha Surendran on 23/11/21.
//

import Foundation

struct FinancialProfileModel: Decodable {
    var category: FinancialProfileCategory?
    var items: [FinancialProfileItemModel]?
    var tip: String?
}

struct FinancialProfileItemModel: Decodable {
    var title: String?
    var type: UIType?
    var options: [String]?
    var value: String?
    var isMandatory: Bool?
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case type = "type"
        case options = "options"
        case value = "value"
        case isMandatory = "isMandatory"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title) ?? ""
        type = try values.decodeIfPresent(UIType.self, forKey: .type) ?? .stringTextField
        options = try values.decodeIfPresent([String].self, forKey: .options) ?? []
        value = try values.decodeIfPresent(String.self, forKey: .value) ?? ""
        isMandatory = try values.decodeIfPresent(Bool.self, forKey: .isMandatory) ?? false
    }
    
    
}

enum UIType: String, Decodable {
    case stringTextField
    case numberTextField
    case picker
    case datePicker
}

enum FinancialProfileCategory: String, Decodable {
    case basicProfile = "BasicProfile"
    case income = "Income"
    case expenses = "Expenses"
    case assets = "Assets"
    case liabilities = "Liabilities"
    case insurance = "Insurance"
    case emergencyPlanning = "Emergency Fund Planning"
}
