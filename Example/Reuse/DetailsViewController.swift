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
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard viewModel != nil else { return }
        setupView(from: viewModel)
    }
    
    private func setupView(from viewModel: PersonViewModel) {
        navigationItem.title = viewModel.name
        nameLabel.text = viewModel.email
        originLabel.text = viewModel.formattedCountry()
        birthdayLabel.text = viewModel.formattedBirthday()
        imageView.image = viewModel.placeholderImage
        
        spinner.startAnimating()
        viewModel.loadImage { [weak self] (image) in
            self?.spinner.stopAnimating()
            self?.imageView.image = image
        }
    }
}
