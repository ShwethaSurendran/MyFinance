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
        profileData.value = getUpdatedProfileData(from: parsedModel.unwrappedValue)
    }
    
    /// Map through parsed models. if there is any item is of 'DatePicker' type, then set its default value as today's date.
    /// - Parameter profileModels: Parsed profile data models
    /// - Returns: Array of updated profile data models
    func getUpdatedProfileData(from profileModels: [FinancialProfileModel]) -> [FinancialProfileModel] {
        var profileModels = profileModels
        profileModels = profileModels.map({
            var profileModel = $0
            var items: [FinancialProfileItemModel] = profileModel.items.unwrappedValue
            items = items.map({
                var profileItemModel = $0
                if profileItemModel.type == .datePicker {
                    profileItemModel.value = CommonUtility.getFormattedDate(from: Date())
                }
                return profileItemModel
            })
            profileModel.items = items
            return profileModel
        })
        return profileModels
    }
    
}
