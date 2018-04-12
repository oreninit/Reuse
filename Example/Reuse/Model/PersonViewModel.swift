//
//  PersonViewModel.swift
//  Reuse_Example
//
//  Created by Oren F on 01/04/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

struct PersonViewModel {
    let name: String
    let email: String
    let birthday: String
    let country: String
    let imageURL: String
    let placeholderImage: UIImage?
    
    func formattedBirthday() -> String {
        return "Born on: \(birthday)"
    }
    
    func formattedCountry() -> String {
        return "From: \(country)"
    }
    
    func loadImage(_ completion: @escaping ((UIImage?) -> ())) {
        guard let url = URL(string: imageURL) else { completion(placeholderImage); return }
        
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url)
            guard let d = data, let image = UIImage(data: d) else {
                self.finish(with: self.placeholderImage, completion: completion)
                return
            }
            self.finish(with: image, completion: completion)
        }
    }
    
    private func finish(with image: UIImage?, completion: @escaping ((UIImage?) -> ())) {
        DispatchQueue.main.async {
            completion(image)
        }
    }
}
