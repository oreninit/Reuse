//
//  Config.swift
//  Reuse_Example
//
//  Created by Oren F on 12/04/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import Reuse

protocol PersonCell {
    var profileImageView: UIImageView! { get }
    var nameLabel: UILabel! { get }
    var emailLabel: UILabel! { get }
}

extension Reuser {
    
    static func configure(withData data: DataProvider, navigator: Navigator?) -> Reuser {
        let reuser = Reuser(dataProvider: data)
        let instanceReuser = PersonReuser(navigator: navigator)
        reuser.register(instanceReuser, for: Person.self)
        return reuser
    }
}
