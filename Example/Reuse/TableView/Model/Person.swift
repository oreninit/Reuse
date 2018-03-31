//
//  Person.swift
//  Reuse_Example
//
//  Created by Oren F on 30/03/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import Reuse

enum Gender: String {
    case female
    case male
}

struct Person: Usable {
    let name: String
    let email: String
    let birthday: Date
    let country: String
    let gender: Gender
}
