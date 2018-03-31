//
//  Handoff.swift
//  Pods-Reuse_Example
//
//  Created by Oren F on 30/03/2018.
//

import UIKit

public extension UITableView {
    
    func handoff(to reuser: Reuser) {
        reuser.tableView = self
        delegate = reuser
        dataSource = reuser
    }
}
