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

    lazy var data: PeopleDatabase = PeopleDatabase()
    
    private var reuser: Reuser!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Friends list"
        reuser = Reuser.configure(withData: data, viewController: self)
        tableView.handoff(to: reuser)
    }
}

private extension Reuser {
    
    static func configure(withData data: DataProvider, viewController: UIViewController) -> Reuser {
        let reuser = Reuser(dataProvider: data)
        let instanceReuser = PersonReuser(viewController: viewController)
        reuser.register(instanceReuser, for: Person.self)
        return reuser
    }
}
