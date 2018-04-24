//
//  Handoff.swift
//  Pods-Reuse_Example
//
//  Created by Oren F on 30/03/2018.
//

import UIKit

public extension UITableView {
    
    /// Pass handling `UITableView` management (dataSource and delegate) to `Reuser`
    /// Helps provide `default` implementation, driven by registered instance reusers
    /// - Parameter reuser: A `Reuser` instance which `knows` how to populate and respond to the table view
    func handoff(to reuser: Reuser) {
        reuser.listView = self
        delegate = reuser
        dataSource = reuser
        reloadData()
    }
}

public extension UICollectionView {
    
    /// Pass handling `UICollectionView` management (dataSource and delegate) to `Reuser`
    /// Helps provide `default` implementation, driven by registered instance reusers
    /// - Parameter reuser: A `Reuser` instance which `knows` how to populate and respond to the collection view
    func handoff(to reuser: Reuser) {
        reuser.listView = self
        delegate = reuser
        dataSource = reuser
        reloadData()
    }
}



/// Internal implementation, shared for UITableView & UICollectionView to avoid the need to use two different references in `Reuser`
internal protocol ListView: class {
    // Common
    func reloadData()
    
    // UITableView
    func deleteRows(at indexPaths: [IndexPath], with animation: UITableViewRowAnimation)
    func moveRow(at indexPath: IndexPath, to newIndexPath: IndexPath)
}

extension ListView {
    func deleteRows(at indexPaths: [IndexPath], with animation: UITableViewRowAnimation) {}
    func moveRow(at indexPath: IndexPath, to newIndexPath: IndexPath) {}
}

extension UITableView: ListView {
}
extension UICollectionView: ListView {
}
