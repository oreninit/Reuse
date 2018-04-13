//
//  Color.swift
//  Reuse_Example
//
//  Created by Oren F on 13/04/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

struct Color: Codable {
    let r: CGFloat
    let g: CGFloat
    let b: CGFloat
}

extension UIColor {
    
    convenience init(color: Color) {
        self.init(red: color.r, green: color.g, blue: color.b, alpha: 1.0)
    }
}
