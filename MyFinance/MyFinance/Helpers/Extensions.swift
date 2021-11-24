//
//  Extensions.swift
//  MyFinance
//
//  Created by Shwetha Surendran on 24/11/21.
//

import UIKit


extension UIViewController {
    /// Show alert with passed parameters
    /// - Parameters:
    ///   - title: Alert title
    ///   - message: Alert message
    ///   - actionHandler: Action to be done on alert action
    func showAlert(title: String, message: String, actionHandler: @escaping() -> Void) {
    let alertController = UIAlertController(title: title, message:
      message, preferredStyle: .alert)
    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in
        actionHandler()
    }))
    self.present(alertController, animated: true, completion: nil)
  }
}
