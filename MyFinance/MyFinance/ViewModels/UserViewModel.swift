//
//  UserViewModel.swift
//  MyFinance
//
//  Created by Shwetha Surendran on 18/12/21.
//

import GoogleSignIn

protocol UserProtocol {
    func getLoggedInUserDetails()-> UserModel
    func save(profileData: FinancialProfileModel, to store: DatabaseProtocol, forUser emailId: String)
    func getExistingProfileData(from store: DatabaseProtocol, forUser emailId: String)-> [FinancialProfileModel]?
}


struct UserViewModel: UserProtocol {
    
    /// Returns logged in user details
    /// - Returns: UserModel object that has all available user details
    func getLoggedInUserDetails()-> UserModel {
        let currentUser = GIDSignIn.sharedInstance.currentUser
        return UserModel(name: (currentUser?.profile?.name).unwrappedValue, email: (currentUser?.profile?.email).unwrappedValue)
    }
    
    /// Save user given data to store
    /// - Parameters:
    ///   - profileData: User profileData
    ///   - store: Database to store data
    ///   - emailId: EmailId of the User under whom to store data
    func save(profileData: FinancialProfileModel, to store: DatabaseProtocol, forUser emailId: String) {
        if !emailId.isEmpty {
            var databaseStore = store
            databaseStore.save(userProfileDetails: profileData, forUser: emailId)
        }
    }
    
    /// Get existing profileData stored for the mentioned User
    /// - Parameters:
    ///   - store: Database from which to retrieve data
    ///   - emailId: EmailId of the User
    /// - Returns: Profile Details in Array format
    func getExistingProfileData(from store: DatabaseProtocol, forUser emailId: String)-> [FinancialProfileModel]? {
        var databaseStore = store
        if let existingProfileData = databaseStore.getUserProfileDetails(withEmail: emailId)  {
            if self.isMandatoryFieldHasValue(profileData: existingProfileData) {
                return existingProfileData
            }
        }
        return nil
    }
    
    /// Check 'isMandatory' key of each profile detail and check if its value is empty
    /// - Parameter profileData: Profile Details on which to check
    /// - Returns: Boolean value indicating if mandatory field has value or not
    private func isMandatoryFieldHasValue(profileData: [FinancialProfileModel])-> Bool {
        let mappedData = (profileData.compactMap({$0.items})).flatMap({$0})
        
        for each in mappedData {
            if (each.isMandatory.unwrappedValue), (each.value.unwrappedValue.isEmpty) {
                return false
            }
        }
        
        return true
    }
    
}
