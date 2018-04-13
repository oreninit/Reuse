//
//  Ad.swift
//  Reuse_Example
//
//  Created by Oren F on 13/04/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import Reuse

struct Ad: Codable, Usable {
    let title: String
    let content: String
    let color: Color
}
