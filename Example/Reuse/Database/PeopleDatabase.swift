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
    
    var data: [Usable]
    
    init() {
        self.data = PeopleDatabase.build()
    }
    
    var objects: [Usable] {
        get { return data }
        set { data = newValue }
    }
    
    func canDeleteObject(at index: ObjectIndex) -> Bool {
        return true
    }
    
    func canMoveObject(at index: ObjectIndex) -> Bool {
        return true
    }
}

private extension PeopleDatabase {
    
    static func build() -> [Usable] {
        
        let people: [Person] = load(from: "people", nestedIn: "friends")
        var ads: [Ad] = load(from: "ads", nestedIn: "ads")

        var database: [Usable] = people
        
        while !ads.isEmpty {
            let ad = ads.removeFirst()
            let index = Int(arc4random_uniform(UInt32(people.count)))
            database.insert(ad, at: index)
        }
        
        return database
    }
    
    static func load<T: Codable>(from file: String, nestedIn key: String) -> [T] {
        guard let path = Bundle.main.path(forResource: file, ofType: "json") else { return [] }
        let url = URL(fileURLWithPath: path)
        guard let data = try? Data(contentsOf: url) else { return [] }
        let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [String : Any]
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        
        var elements = [T]()
        
        if let array = json[key] as? [Any] {
            for element in array {
                let objectData = try! JSONSerialization.data(withJSONObject: element, options: [])
                if let object = try? decoder.decode(T.self, from: objectData) {
                    elements.append(object)
                }
            }
        }
        
        return elements
    }
}
