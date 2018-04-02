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
    
    func canMoveObject(at index: ObjectIndex) -> Bool {
        return true
    }
}

private extension PeopleDatabase {
    
    static func build() -> [Person] {
        guard let path = Bundle.main.path(forResource: "people", ofType: "json") else { return [] }
        let url = URL(fileURLWithPath: path)
        guard let data = try? Data(contentsOf: url) else { return [] }
        let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [String : Any]
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        
        var people = [Person]()
        
        if let array = json["friends"] as? [Any] {
            for element in array {
                let objectData = try! JSONSerialization.data(withJSONObject: element, options: [])
                if let object = try? decoder.decode(Person.self, from: objectData) {
                    people.append(object)
                }
            }
        }
        
        return people
    }
}
