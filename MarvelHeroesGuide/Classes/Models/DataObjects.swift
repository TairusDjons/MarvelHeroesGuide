//
//  DataObject.swift
//  MarvelHeroesGuide
//
//  Created by Tairus Djons on 26.07.2018.
//  Copyright © 2018 Tairus Djons. All rights reserved.
//

import Foundation

struct DataObject {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    
    init(offset: Int, limit: Int, total: Int, count: Int) {
        self.count = count
        self.offset = offset
        self.limit = limit
        self.total = total
    }
}


struct CharacterData {
    let data: DataObject
    let results: [Character]
    
    init () {
        self.data = DataObject(offset: 0, limit: 0, total: 0, count: 0)
        self.results = [Character]()
    }
    
    init (data: DataObject, results: [Character]) {
        self.data = data
        self.results = results
    }
}

struct EventData {
    let data: DataObject
    let results: [Event]
}
