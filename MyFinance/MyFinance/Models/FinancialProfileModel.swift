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
    
    init(category: FinancialProfileCategory, items: [FinancialProfileItemModel], tip: String) {
        self.category = category
        self.items = items
        self.tip = tip
    }
    
    enum CodingKeys: String, CodingKey {
        case category = "category"
        case items = "items"
        case tip = "tip"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        category = try values.decodeIfPresent(FinancialProfileCategory.self, forKey: .category)
        items = try values.decodeIfPresent([FinancialProfileItemModel].self, forKey: .items) ?? []
        tip = try values.decodeIfPresent(String.self, forKey: .tip).unwrappedValue
    }
    
}

struct FinancialProfileItemModel: Decodable {
    var title: String?
    var type: UIType?
    var options: [String]?
    var value: String?
    var isMandatory: Bool?
    
    init(title: String?, type: UIType?, options: [String]?, value: String?,
         isMandatory: Bool?) {
        self.title = title
        self.type = type
        self.options = options
        self.value = value
        self.isMandatory = isMandatory
    }
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case type = "type"
        case options = "options"
        case value = "value"
        case isMandatory = "isMandatory"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title).unwrappedValue
        type = try values.decodeIfPresent(UIType.self, forKey: .type) ?? .stringTextField
        options = try values.decodeIfPresent([String].self, forKey: .options).unwrappedValue
        value = try values.decodeIfPresent(String.self, forKey: .value).unwrappedValue
        isMandatory = try values.decodeIfPresent(Bool.self, forKey: .isMandatory).unwrappedValue
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
