//
//  DataObject.swift
//  MarvelHeroesGuide
//
//  Created by Tairus Djons on 26.07.2018.
//  Copyright © 2018 Tairus Djons. All rights reserved.
//

import Foundation

struct DataObject<T: MarvelBaseObject> {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [T]
    
    init () {
        self.count = 0
        self.offset = 0
        self.total = 0
        self.limit = 0
        self.results = [T]()
    }
    
    init(offset: Int, limit: Int, total: Int, count: Int, collection: [T]) {
        self.count = count
        self.offset = offset
        self.limit = limit
        self.total = total
        self.results = collection
    }
}

