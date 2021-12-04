//
//  Protocols.swift
//  MyFinance
//
//  Created by Shwetha Surendran on 27/11/21.
//

import Foundation

/// Protocol for handling add/update user profile details
protocol ProfileDataUpdateProtocol {
    func updateValue(value: String, index: Int)
}


/// Protocol defining UITableViewCell reuse identifier
protocol ReusableView {
    static var reuseIdentifier: String { get }
}

extension ReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}


protocol Defaultable {
    static var defaultValue: Self { get }
}
