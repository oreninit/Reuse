//
//  DataInstanceReuser.swift
//  Pods-Reuse_Example
//
//  Created by Oren F on 28/03/2018.
//

import Foundation

internal enum DataAction {
    case none(IndexPath)
    case delete(IndexPath)
    case insert(IndexPath)
    case move(IndexPath, IndexPath)
    
    var indexPath: IndexPath {
        switch self {
        case .none(let ip): return ip
        case .delete(let ip): return ip
        case .insert(let ip): return ip
        case .move(let from, _): return from
        }
    }
}

/// Internal InstanceReuser which wraps every reuser and attaches the database for actions. Used be `Reuser`
internal struct DataInstanceReuser: InstanceReuser {
    
    // MARK:- InstanceReuser
    var viewIdentifier: String { return reuser.viewIdentifier }
    var height: CGFloat { return reuser.height }
    var size: CGSize { return reuser.size }
    mutating func setObject(_ object: Usable) { reuser.setObject(object) }
    func configure(_ reusable: Reusable) -> Bool { return reuser.configure(reusable) }
    func select() { reuser.select() }
    
    
    // MARK:- Internal
    weak var data: DataProvider!
    var indexPath: IndexPath
    var reuser: InstanceReuser
    var closure: ((DataAction) -> ())
    
    func canDelete() -> Bool {
        return data.canDeleteObject(at: objectIndex())
    }
    
    func delete() {
        guard data.deleteObject(at: objectIndex()) else {
            closure(.none(indexPath))
            return
        }
        closure(.delete(indexPath))
    }
    
    func canBeMoved() -> Bool {
        return data.canMoveObject(at: objectIndex())
    }
    
    func move(to newIndexPath: IndexPath) {
        guard data.moveObject(from: objectIndex(), to: objectIndex(for: newIndexPath)) else {
            closure(.none(indexPath))
            return
        }
        closure(.move(indexPath, newIndexPath))
    }
    
    // MARK:- Indices
    private func objectIndex() -> ObjectIndex {
        return objectIndex(for: self.indexPath)
    }
    
    private func objectIndex(for indexPath: IndexPath) -> ObjectIndex {
        let section = data.sections[indexPath.section]
        let index = ObjectIndex(indexPath: indexPath, section: section)
        return index
    }
}
