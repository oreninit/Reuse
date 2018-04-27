//
//  InstanceReuser.swift
//  Pods-Reuse_Example
//
//  Created by Oren F on 28/03/2018.
//

import UIKit

public protocol InstanceReuser {
    
    // The dequeue reuse identifier for the corresponding view
    var viewIdentifier: String { get }
    // For UITableViewCell. Default is UITableViewAutomaticDimension
    var height: CGFloat { get }
    // For UICollectionViewCell. Default is CGSize.zero
    var size: CGSize { get }
    // In cases where an `InstanceReuser` isn't registered for a specific `Object`, a default one will be provided to avoid using optionals. This could be used before attempting to dequeue new cells, and possibly `assert` to avoid unimplemented reusers
    var isValidReuser: Bool { get }
    
    
    /// A function that feeds the current object for upcoming operations
    ///
    /// - Parameter object: a `Usable` instance, as defined upon registering `InstanceReuser`'s
    /// - Returns:
    mutating func setObject(_ object: Usable)
    
    
    /// A function that receives a `Reusable` (i.e a cell) to configure
    ///
    /// - Parameter reusable: Any instance that conforms to `Reusable`. Mostly a UITableViewCell/UICollectionViewCell
    /// - Returns: A boolean whether the configuration was successful
    @discardableResult
    func configure(_ reusable: Reusable) -> Bool
    
    /// An action when the item's cooresponding indexPath was selected in the tableView/collectionView
    ///
    /// - Returns:
    func select()
    
    /// A function to decide whether a cell should allow deletion option at current indexPath
    ///
    /// - Returns: A boolean to say whether the cell in this indexPath should show delete option
    func canDelete() -> Bool
    
    /// A function to delete object at current indexPath. Message will be passed to the `DataProvider` to mutate the data
    ///
    /// - Returns:
    func delete()
    
    /// A function to decide whether a cell should be allowed to move to a different indexPath
    ///
    /// - Returns: A boolean to say whether the cell in this indexPath should be movable
    func canBeMoved() -> Bool
    
    /// A function to move object at current indexPath to a new indexPath. Message will be passed to the `DataProvider` to mutate the data
    ///
    /// - Parameter indexPath: Target indexPath for object
    func move(to indexPath: IndexPath)
}

public extension InstanceReuser {
    var height: CGFloat { return UITableViewAutomaticDimension }
    var size: CGSize { return .zero }
    var isValidReuser: Bool { return viewIdentifier != NullInstanceReuser.id }
    func select() {}
    func canDelete() -> Bool { return false }
    func delete() {}
    func canBeMoved() -> Bool { return false }
    func move(to indexPath: IndexPath) {}
}
