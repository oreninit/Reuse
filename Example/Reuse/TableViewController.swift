//
//  TableViewController.swift
//  Reuse_Example
//
//  Created by Oren F on 30/03/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import Reuse

class TableViewController: UIViewController {

    private var reuser: Reuser!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.handoff(to: reuser)
    }
}
