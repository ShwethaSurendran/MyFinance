//
//  Observer.swift
//  MyFinance
//
//  Created by Shwetha Surendran on 24/11/21.
//

import Foundation


/// Common Observable for ViewModel binding
struct Observable<T> {
    
    private var listener : ((T) -> Void)? = nil
    
    /// Value to be observed.
    /// Calls listener method when changing value
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ newValue: T) {
        value = newValue
    }
    
    /// Bind passed closure method to value
    /// - Parameter currentListener: Closure method to be called when value changes
    mutating func bind(_ currentListener: @escaping (T) -> Void) {
        currentListener(value)
        listener = currentListener
    }
    
}
