//
//  AdReuser.swift
//  Reuse_Example
//
//  Created by Oren F on 13/04/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import Reuse

struct AdReuser: InstanceReuser {
    var viewIdentifier: String { return "ad.cell.id" }
    var height: CGFloat { return UITableViewAutomaticDimension }
    var size: CGSize { return CGSize(width: UIScreen.main.bounds.width - 20, height: 120.0) }
    
    private var ad: Ad?
    
    mutating func setObject(_ object: Usable) {
        ad = object as? Ad
    }
    
    func configure(_ reusable: Reusable) -> Bool {
        guard let ad = ad, let cell = reusable as? AdCell else { return false }
        cell.container.backgroundColor = UIColor(color: ad.color)
        cell.titleLabel.text = ad.title
        cell.contentLabel.text = ad.content
        return true
    }
    
    func select() {
    }
    
    func canDelete() -> Bool {
         return false
    }
    
    func canBeMoved() -> Bool {
         return false
    }

}
