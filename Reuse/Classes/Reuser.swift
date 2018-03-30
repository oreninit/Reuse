//
//  Reuser.swift
//  Pods-Reuse_Example
//
//  Created by Oren F on 28/03/2018.
//

import UIKit

public class Reuser: NSObject {
    
    internal var instances: [String : InstanceReuser] = [:]
    internal var dataProvider: DataProvider
    internal weak var tableView: UITableView?
    
    public init(dataProvider: DataProvider) {
        self.dataProvider = dataProvider
        super.init()
    }
    
    // MARK:- Public
    public func attach(_ tableView: UITableView?) {
        self.tableView = tableView
    }
    
    func register(_ instanceReuser: InstanceReuser, for object: Usable.Type) {
        instances[object.name] = instanceReuser
    }
    
    public func numberOfSections() -> Int {
        return dataProvider.sections.count
    }
    
    public func numberOfItems(in section: Int) -> Int {
        return dataProvider.sections[section].objects.count
    }
    
    public func on(indexPath: IndexPath) -> InstanceReuser {
        let object = getObject(at: indexPath)
        guard let instance = instances[object.name] else {
            return NullInstanceReuser()
        }
        var dataReuser = DataInstanceReuser(data: dataProvider, indexPath: indexPath, reuser: instance) { [weak self]
            action in
            
            switch action {
            case .delete(let ip):
                self?.tableView?.deleteRows(at: [ip], with: .automatic)
            case .move(let from, let to):
                self?.tableView?.moveRow(at: from, to: to)
            default: break
            }
        }
        dataReuser.setObject(object)
        return dataReuser
    }
    
    // MARK:- Private
    internal func getObject(at indexPath: IndexPath) -> Usable {
        return dataProvider.sections[indexPath.section].objects[indexPath.item]
    }
}

