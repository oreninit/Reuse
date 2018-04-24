//
//  HeaderReuser.swift
//  Pods-Reuse_Example
//
//  Created by Oren F on 20/04/2018.
//

import UIKit

public protocol HeaderReuser {
    
    
    // The dequeue reuse identifier for the corresponding view
    var viewIdentifier: String? { get }
    // For UITableViewCell. Default is UITableViewAutomaticDimension
    var height: CGFloat { get }
    
    
    
    mutating func setObject(_ object: Usable?)
    
    func reusable(for section: Int) -> ReusableHeader
    
    func configure(_ reusable: ReusableHeader) -> UIView?
}

public extension HeaderReuser {
    var viewIdentifier: String? { return nil }
    var height: CGFloat { return 0 }
}
