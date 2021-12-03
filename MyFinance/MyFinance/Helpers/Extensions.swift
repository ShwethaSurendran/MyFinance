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


extension UITableViewCell: ReusableView {}

extension UITableView {
    
    /// Returns a reusable table-view cell
    /// - Parameter indexPath: The index path specifying the location of the cell
    /// - Returns: A UITableViewCell object with the associated reuse identifier. This method always returns a valid cell.
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable to Dequeue Reusable Table View Cell")
        }
        cell.tag = indexPath.row
        return cell
    }

}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    /// Generates random color
    /// - Returns: UIColor generated randomly
    static func random() -> UIColor {
        return UIColor(
           red:   .random(),
           green: .random(),
           blue:  .random(),
           alpha: 1.0
        )
    }
}


extension UIStoryboard {
    func instantiateVC<T: UIViewController>() -> T? {
        if let name = NSStringFromClass(T.self).components(separatedBy: ".").last {
            return instantiateViewController(withIdentifier: name) as? T
        }
        return nil
    }
}
