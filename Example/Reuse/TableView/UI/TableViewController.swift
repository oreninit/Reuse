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
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editingToggle))
        reuser = Reuser.configure(withData: data, viewController: self)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @objc private func editingToggle() {
        tableView.isEditing = !tableView.isEditing
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

extension TableViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return reuser.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reuser.numberOfItems(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let instance = reuser[indexPath]
        guard instance.isValidReuser else {
            assert(false, "InstanceReuser invalid")
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: instance.viewIdentifier, for: indexPath)
        instance.configure(cell)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        reuser[indexPath].select()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return reuser[indexPath].height
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return reuser[indexPath].canDelete()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        reuser[indexPath].delete()
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return reuser[indexPath].canBeMoved()
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        reuser[sourceIndexPath].move(to: destinationIndexPath)
    }

}
