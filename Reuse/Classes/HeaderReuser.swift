//
//  HeaderReuser.swift
//  Pods-Reuse_Example
//
//  Created by Oren F on 20/04/2018.
//

import UIKit

public protocol HeaderReuser {
    
    // The dequeue reuse identifier for the corresponding view
    var viewIdentifier: String? { get }
    // For UITableViewCell. Default is UITableViewAutomaticDimension
    var height: CGFloat { get }
    
    
    /// A function that feeds the current object for upcoming operations
    ///
    /// - Parameter object: a `Usable` instance, as defined upon registering `HeaderReuser`'s
    /// - Returns:
    mutating func setObject(_ object: Usable?)
    
    /// A point to create an instance which can generate a header view
    ///
    /// - Parameter section: Index of current section
    /// - Returns: An object conforming to `ReusableHeader`
    func reusable(for section: Int) -> ReusableHeader
    
    /// A function that receives a `ReusableHeader` to configure
    ///
    /// - Parameter reusable: Any instance that conforms to `ReusableHeader`
    /// - Returns: An optional view to be set as header
    func configure(_ reusable: ReusableHeader) -> UIView?
}

public extension HeaderReuser {
    var viewIdentifier: String? { return nil }
    var height: CGFloat { return 0 }
}
