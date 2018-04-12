//
//  PersonReuser.swift
//  Reuse_Example
//
//  Created by Oren F on 31/03/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import Reuse

struct PersonReuser: InstanceReuser {
    
    var viewIdentifier: String { return "person.cell.id" }
    var height: CGFloat { return 80.0 }
    var size: CGSize { return CGSize(width: 150.0, height: 150.0) }
    
    private var person: Person?
    private var formatter: DateFormatter
    private var navigator: Navigator?
    
    init(navigator: Navigator?) {
        self.navigator = navigator
        formatter = DateFormatter()
        formatter.dateFormat = "EEEE, dd.MM.yyyy"
    }
    
    mutating func setObject(_ object: Usable) {
        person = object as? Person
    }
 
    func configure(_ reusable: Reusable) -> Bool {
        guard let person = person, let cell = reusable as? PersonCell else { return false }
        
        cell.profileImageView?.image = UIImage(named: person.gender.rawValue)
        cell.profileImageView?.tintColor = (person.gender == .male) ? .blue : .purple
        cell.nameLabel?.text = person.name
        cell.emailLabel?.text = person.country
        return true
    }
    
    func select() {
        guard let person = person else { return }
        let personVM = PersonViewModel(name: person.name,
                                       email: person.email,
                                       birthday: formatter.string(from: person.birthday),
                                       country: person.country,
                                       imageURL: person.image,
                                       placeholderImage: UIImage(named: person.gender.rawValue))
        navigator?.showDetails(of: personVM)
    }
}

