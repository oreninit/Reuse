//
//  Usable.swift
//  Pods-Reuse_Example
//
//  Created by Oren F on 28/03/2018.
//

import Foundation


/// A protocol describing an object that can be used to configure a `Reusable`
public protocol Usable {
}

internal extension Usable {
    static var name: String { return String("\(type(of: self))".split(separator: ".").first ?? "")
}
    var name: String { return "\(type(of: self))" }
}
