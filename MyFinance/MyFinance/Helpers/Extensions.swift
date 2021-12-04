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


///Extending UIStoryboard, to instantiate ViewController from the storyboard it is present
extension UIStoryboard {
    func instantiateVC<T: UIViewController>() -> T? {
        if let name = NSStringFromClass(T.self).components(separatedBy: ".").last {
            return instantiateViewController(withIdentifier: name) as? T
        }
        return nil
    }
}


///Extending Optional to provide default value for whatever types that confirms to 'Defaultable' protocol
extension Optional where Wrapped: Defaultable {
    var unwrappedValue: Wrapped { return self ?? Wrapped.defaultValue }
}


/// Returns '0' as default value if there is no integer value present
extension Int: Defaultable {
    static var defaultValue: Int { return 0 }
}


/// Returns empty string("") as default value if there is no string value present
extension String: Defaultable {
    static var defaultValue: String { return "" }
}


/// Returns empty array([]) as default value if there is no array present
extension Array: Defaultable {
    static var defaultValue: Array<Element> { return [] }
}


/// Returns 'false' as default value if there is no boolean value present
extension Bool: Defaultable {
    static var defaultValue: Bool { return false }
}


/// Returns '0' as default value if there is no double value present
extension Double: Defaultable {
    static var defaultValue: Double { return 0 }
}


///Check if Array contains given index
extension Array {
    func isValidIndex(_ index : Int) -> Bool {
        guard index >= 0 else {return false}
        return index < self.count
    }
}
