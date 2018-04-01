//
//  DetailsViewController.swift
//  Reuse_Example
//
//  Created by Oren F on 30/03/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    var viewModel: PersonViewModel!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = viewModel.name
        nameLabel.text = viewModel.email
        imageView.image = viewModel.placeholderImage
        viewModel.loadImage { [weak self] (image) in
            self?.imageView.image = image
        }
    }
}
