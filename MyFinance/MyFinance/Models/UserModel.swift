//
//  LoginModel.swift
//  MyFinance
//
//  Created by Shwetha Surendran on 17/12/21.
//

import Foundation


struct UserModel {
    
    var name: String?
    var email: String?
    
    init(name: String?, email: String?) {
        self.name = name
        self.email = email
    }
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case email = "email"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name).unwrappedValue
        email = try values.decodeIfPresent(String.self, forKey: .email).unwrappedValue
    }
    
}
