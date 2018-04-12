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
        reuser.tableView = self
        delegate = reuser
        dataSource = reuser
    }
}
