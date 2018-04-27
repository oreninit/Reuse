//
//  AnyHeaderReuser.swift
//  Pods-Reuse_Example
//
//  Created by Oren F on 21/04/2018.
//

import Foundation

/// A generic HeaderReuser where each instance defines it's own `ReusableHeader` and `Usable`
public struct AnyHeaderReuser<R: ReusableHeader, O: Usable>: HeaderReuser {
    
    public var object: O? = nil
    public weak var section: Section?
    
    public var viewIdentifier: String?
    public var height: CGFloat
    public var closure: ((R, O) -> ())
    
    private var reusableHeaderType: R.Type
    
    public init(viewIdentifier: String? = nil,
                height: CGFloat,
                closure: @escaping ((R, O) -> ())) {
        self.viewIdentifier = viewIdentifier
        self.height = height
        self.closure = closure
        self.reusableHeaderType = R.self
    }
    
    public mutating func setObject(_ object: Usable?) {
        self.object = object as? O
    }
    
    public func reusable(for section: Int) -> ReusableHeader {
        return reusableHeaderType.newInstance()
    }
    
    public func configure(_ reusable: ReusableHeader) -> UIView? {
        guard let object = object, let view = reusable as? R else { return nil }
        closure(view, object)
        return view.view
    }
}
