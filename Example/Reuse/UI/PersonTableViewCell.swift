//
//  PersonTableViewCell.swift
//  Reuse_Example
//
//  Created by Oren F on 31/03/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class PersonTableViewCell: UITableViewCell, PersonCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
}
