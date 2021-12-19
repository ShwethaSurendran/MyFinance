//
//  CustomNavigation.swift
//  MyFinance
//
//  Created by Shwetha Surendran on 18/12/21.
//

import UIKit


class CustomNavigation: UINavigationController {
    
    /// Initialize new UINavigationController with mentioned root view
    /// - Parameter rootView: The view controller that resides at the bottom of the navigation stack
    convenience init(rootView: UIViewController) {
        self.init(rootViewController: rootView)
        self.navigationBar.isHidden = true
    }
    
}
