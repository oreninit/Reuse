//
//  PeopleDatabase.swift
//  Reuse_Example
//
//  Created by Oren F on 31/03/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import Reuse

class PeopleDatabase: Section, DataProvider {
    
    var people: [Person]
    
    init() {
        self.people = PeopleDatabase.build()
    }
    
    var objects: [Usable] {
        get { return people }
        set { people = (newValue as? [Person] ?? []) }
    }
    
    func canDeleteObject(at index: ObjectIndex) -> Bool {
        return true
    }
}

private extension PeopleDatabase {
    
    static func build() -> [Person] {
        
        var people: [Person] = []
        
        people.append(Person(name: "Jack Flack",
                             email: "jflack@hoster.com",
                             birthday: Date(timeIntervalSince1970: -10886400),
                             country: "USA",
                             gender: .male))
        people.append(Person(name: "Gwyneth Caltrow",
                             email: "shesaid@irule.com",
                             birthday: Date(timeIntervalSince1970: 86400000),
                             country: "USA",
                             gender: .female))
        people.append(Person(name: "Keira Brightley",
                             email: "brightk@joy.co.uk",
                             birthday: Date(timeIntervalSince1970: 480643200),
                             country: "England",
                             gender: .female))
        people.append(Person(name: "Morgan Greeman",
                             email: "mg@lama.com",
                             birthday: Date(timeIntervalSince1970: -1028332800),
                             country: "USA",
                             gender: .male))
        people.append(Person(name: "Kirsten Munst",
                             email: "munter@kirst.co.de",
                             birthday: Date(timeIntervalSince1970: 388972800),
                             country: "Germany",
                             gender: .female))
        people.append(Person(name: "Adam Dandler",
                             email: "adandler@gilmore.com",
                             birthday: Date(timeIntervalSince1970: -104544000),
                             country: "USA",
                             gender: .male))

        return people
    }
}
