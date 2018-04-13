//
//  AdTableViewCell.swift
//  Reuse_Example
//
//  Created by Oren F on 13/04/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class AdTableViewCell: UITableViewCell, AdCell {

    var container: UIView! { return contentView }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
}
