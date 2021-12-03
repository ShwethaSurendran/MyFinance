//
//  JSONParser.swift
//  MyFinance
//
//  Created by Shwetha Surendran on 24/11/21.
//

import Foundation

protocol JSONParserProtocol {
    func decodeJSON<T:Decodable>(from fileName: String)-> T?
}

struct JSONParser: JSONParserProtocol {
    /// Decode JSON to requested model
    /// - Parameter fileName: Name of JSON file in the Bundle, to decode from
    /// - Returns: Model parsed from JSON
    func decodeJSON<T:Decodable>(from fileName: String)-> T?{
        guard let fileUrl = Bundle.main.url(forResource: fileName, withExtension: Constants.FileExtension.json), let jsonData = try? Data(contentsOf: fileUrl) else{return nil}
        let responseModel = try? JSONDecoder().decode(T.self, from: jsonData)
        return responseModel
    }
}
