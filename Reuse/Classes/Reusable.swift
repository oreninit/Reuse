//
//  Reusable.swift
//  Pods-Reuse_Example
//
//  Created by Oren F on 28/03/2018.
//

import UIKit

/// A protocol describing an object that will be configured using a `Usable`
public protocol Reusable {}

public protocol ReusableHeader {
    static func newInstance() -> ReusableHeader
    var view: UIView? { get }
}

// MARK: - UIView: Reusable
/// By default, every view is reusable
extension UIView: Reusable {}

extension ReusableHeader where Self: UIView {
    public var view: UIView? { return self }
}
