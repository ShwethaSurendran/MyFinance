//
//  FinancePlannerModel.swift
//  MyFinance
//
//  Created by Shwetha Surendran on 23/11/21.
//

import Foundation

struct FinancialProfileModel: Codable {
    var category: String?
    var items: [FinancialProfileItemModel]?
}

struct FinancialProfileItemModel: Codable {
    var title: String?
    var type: String?
    var value: String?
}

