//
//  PersonCollectionViewCell.swift
//  Reuse_Example
//
//  Created by Oren F on 12/04/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class PersonCollectionViewCell: UICollectionViewCell, PersonCell {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
}
