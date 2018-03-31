//
//  PersonTableViewCell.swift
//  Reuse_Example
//
//  Created by Oren F on 31/03/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class PersonTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 15
    }
}
