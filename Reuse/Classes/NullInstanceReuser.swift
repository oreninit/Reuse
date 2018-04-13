//
//  NullInstanceReuser.swift
//  Pods-Reuse_Example
//
//  Created by Oren F on 28/03/2018.
//

import CoreGraphics

internal struct NullInstanceReuser: InstanceReuser {
    
    static var id: String { return "com.reuser.null.instance" }
    
    var viewIdentifier: String { return NullInstanceReuser.id }
    var height: CGFloat { return 0 }
    var size: CGSize { return .zero }
    func setObject(_ object: Usable) {}
    func configure(_ reusable: Reusable) -> Bool { return false }
    var isValidReuser: Bool { return false }
}

