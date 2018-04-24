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

protocol AdCell {
    var container: UIView! { get }
    var titleLabel: UILabel! { get }
    var contentLabel: UILabel! { get }
}

extension Reuser {
    
    static func configure(withData data: DataProvider, navigator: Navigator?) -> Reuser {
        let reuser = Reuser(dataProvider: data)
        let instanceReuser = PersonReuser(navigator: navigator)
        reuser.register(instanceReuser, forObject: Person.self)
        reuser.register(AdReuser(), forObject: Ad.self)
        
        let header = AnyHeaderReuser<UILabel, Int>(height: 40.0, closure: { view, object in
            view.text = "   \(object) friends"
        })
        reuser.register(header, forHeader: Int.self)
        
        return reuser
    }    
}

extension Int: Usable {}
extension UILabel: ReusableHeader {
    
    public static func newInstance() -> ReusableHeader {
        let label = UILabel(frame: .zero)
        label.backgroundColor = .white
        label.textColor = .purple
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        return label
    }
}
