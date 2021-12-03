//
//  FinancialProfileViewModel.swift
//  MyFinance
//
//  Created by Shwetha Surendran on 24/11/21.
//

import Foundation


struct FinancialProfileViewModel {
    
    var profileData: Observable<[FinancialProfileModel]?> = Observable(nil)
    
    init(fileNameToLoadDataFrom fileName: String, jsonParser: JSONParserProtocol) {
        getProfileData(fromJSONFile: fileName, jsonParser: jsonParser)
    }
    
    /// Get parsed profile data model from the requested JSON file
    /// - Parameter fileName: Name of JSON file in the Bundle, to decode from
    mutating func getProfileData(fromJSONFile fileName: String, jsonParser: JSONParserProtocol) {
        let parsedModel: [FinancialProfileModel]? = jsonParser.decodeJSON(from: fileName)
        profileData.value = parsedModel
    }
    
}
