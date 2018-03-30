//
//  AnyInstaceReuser.swift
//  Pods-Reuse_Example
//
//  Created by Oren F on 29/03/2018.
//

import Foundation

public struct AnyInstanceReuserObj<R: Reusable, O: Usable>: InstanceReuser {
    
    public var viewIdentifier: String { return reuseId }
    public var height: CGFloat { return fixedHeight }
    public var size: CGSize { return fixedSize }
    
    var reuseId: String
    var fixedHeight: CGFloat
    var fixedSize: CGSize
    var closure: ((R, O) -> ())
    
    public var isValidReuser: Bool { return object != nil && viewIdentifier != "" }
    
    public init(reuseId: String,
                cellHeight: CGFloat = UITableViewAutomaticDimension,
                cellSize: CGSize = .zero,
                closure: @escaping ((R, O) -> ())) {
        self.reuseId = reuseId
        self.fixedHeight = cellHeight
        self.fixedSize = cellSize
        self.closure = closure
    }
    
    private var object: O? = nil
    
    public mutating func setObject(_ object: Usable) {
        guard let o = object as? O else { return }
        self.object = o
    }
    
    public func configure(_ reusable: Reusable) -> Bool {
        guard let object = object, let view = reusable as? R else { return false }
        closure(view, object)
        return true
    }
    
    public func select() {}
    
    public func canDelete() -> Bool { return false }
    public func delete() {}
    
    public func canBeMoved() -> Bool { return false }
    public func move(to indexPath: IndexPath) {}
}

