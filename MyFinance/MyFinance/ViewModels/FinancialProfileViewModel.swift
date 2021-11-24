//
//  FinancialProfileViewModel.swift
//  MyFinance
//
//  Created by Shwetha Surendran on 24/11/21.
//

import Foundation


struct FinancialProfileViewModel {
    
    var profileData: Observable<[FinancialProfileModel]?> = Observable(nil)
    
    /// Get parsed profile data model from the requested JSON file
    /// - Parameter fileName: Name of JSON file in the Bundle, to decode from
    mutating func getProfileData(fromJSONFile fileName: String) {
        let parsedModel: [FinancialProfileModel]? = JSONParser.decodeJSON(from: fileName)
        profileData.value = parsedModel
    }
    
}
