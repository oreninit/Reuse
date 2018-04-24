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
    internal var headerInstances: [String : HeaderReuser] = [:]
    internal var headers: [Int : ReusableHeader?] = [:]
    internal var dataProvider: DataProvider
    
    internal weak var listView: ListView?
    
    public var requiresHeaderUpdateOnDataChange: Bool = true
    
    public init(dataProvider: DataProvider) {
        self.dataProvider = dataProvider
        super.init()
    }
    
    // MARK:- Public
    
    /// Register an instance of `InstanceReuser` type to a specific `Usable` object
    ///
    /// - Parameters:
    ///   - instanceReuser: An object which conforms to `InstanceReuser`
    ///   - object: An object that could be used to configure a `Reusable`
    public func register(_ instanceReuser: InstanceReuser, forObject object: Usable.Type) {
        instances[object.name] = instanceReuser
    }
    
    /// Register an instance of `InstanceReuser` type to a specific `Usable` object
    ///
    /// - Parameters:
    ///   - instanceReuser: An object which conforms to `InstanceReuser`
    ///   - header: An object that could be used to configure a `Reusable`
    public func register(_ instanceReuser: HeaderReuser, forHeader header: Usable.Type) {
        headerInstances[header.name] = instanceReuser
    }
    
    /// Pass UITableView reference to `Reuser`.
    /// Used to update UI when an action is performed (i.e delete, move, reload)
    ///
    /// - Parameter tableView: A UITableView instance
    public func setTableView(_ tableView: UITableView?) {
        self.listView = tableView
    }
    
    public func setCollectionView(_ collectionView: UICollectionView?) {
        self.listView = collectionView
    }
    
    public func reload() {
        listView?.reloadData()
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
        return NullInstanceReuser()
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
                self?.listView?.deleteRows(at: [ip], with: .automatic)
            case .move(let from, let to):
                self?.listView?.moveRow(at: from, to: to)
            default: break
            }
            
            if let headerShouldUpdate = self?.requiresHeaderUpdateOnDataChange, headerShouldUpdate {
                self?.reloadHeader(at: indexPath.section)
            }
        }
        dataReuser.setObject(object)
        return dataReuser
    }

    public func headerAt(index: Int) -> HeaderReuser? {
        guard let instance = getHeader(at: index) else { return nil }
        return instance
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
    
    internal func getHeaderObject(at index: Int) -> Usable? {
        guard index < dataProvider.sections.count else { return nil }
        return dataProvider.sections[index].headerObject
    }
    
    internal func getInstance(on indexPath: IndexPath) -> InstanceReuser {
        do {
            let instance = try on(indexPath: indexPath)
            return instance
        }
        catch {
            assert(false, error.localizedDescription)
        }
        return NullInstanceReuser()
    }

    internal func getHeader(at index: Int) -> HeaderReuser? {
        guard let object = dataProvider.sections[index].headerObject,
            var instance = headerInstances[object.name] else { return nil }
        instance.setObject(object)
        return instance
    }

    @discardableResult
    internal func getHeaderView(at index: Int) -> UIView? {
        guard let object = dataProvider.sections[index].headerObject,
            var instance = headerInstances[object.name] else {
            headers[index] = nil
            return nil
        }
        var reusable: ReusableHeader!
        if let existing = headers[index] {
            reusable = existing
        } else {
            reusable = instance.reusable(for: index)
            headers[index] = reusable
        }
        instance.setObject(object)
        return instance.configure(reusable)
    }
    
    internal func reloadHeader(at index: Int) {
        getHeaderView(at: index)
    }
}

