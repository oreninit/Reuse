//
//  Reuser.swift
//  Pods-Reuse_Example
//
//  Created by Oren F on 28/03/2018.
//

import UIKit

internal enum ReuserError: Error, LocalizedError {
    case indexOutOfBounds(IndexPath)
    case reuserMissing(String)
    
    var errorDescription: String? {
        switch self {
        case .indexOutOfBounds(let ip):
            return "Reuser Error: index out bounds (\(ip))"
        case .reuserMissing(let type):
            return "Reuser Error: no `InstanceReuser` assigned for \(type)"
        }
    }
}


public class Reuser: NSObject {
    
    internal var instances: [String : InstanceReuser] = [:]
    internal var dataProvider: DataProvider
    internal weak var tableView: UITableView?
    
    public init(dataProvider: DataProvider) {
        self.dataProvider = dataProvider
        super.init()
    }
    
    // MARK:- Public
    // Attach elements
    public func register(_ instanceReuser: InstanceReuser, for object: Usable.Type) {
        instances[object.name] = instanceReuser
    }
    
    public func setTableView(_ tableView: UITableView?) {
        self.tableView = tableView
    }

    // Get InstanceReuser
    public subscript(indexPath: IndexPath) -> InstanceReuser {
        do {
            let reuser = try on(indexPath: indexPath)
            return reuser
        }
        catch {
            assert(false, error.localizedDescription)
        }
    }
    
    public func on(indexPath: IndexPath) throws -> InstanceReuser {
        let object = try getObject(at: indexPath)
        guard let instance = instances[object.name] else {
            throw ReuserError.reuserMissing(object.name)
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

    // TableData
    
    public func numberOfSections() -> Int {
        return dataProvider.sections.count
    }
    
    public func numberOfItems(in section: Int) -> Int {
        return dataProvider.sections[section].objects.count
    }
    
    // MARK:- Private
    internal func getObject(at indexPath: IndexPath) throws -> Usable {
        guard dataProvider.isInBounds(indexPath) else {
            throw ReuserError.indexOutOfBounds(indexPath)
        }
        return dataProvider.sections[indexPath.section].objects[indexPath.item]
    }
}

