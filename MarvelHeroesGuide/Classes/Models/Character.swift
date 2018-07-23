//
//  Charachter.swift
//  MarvelHeroesGuide
//
//  Created by Tairus Djons on 20.07.2018.
//  Copyright © 2018 Tairus Djons. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Character: ResourceItem, Hashable{
    static func == (lhs: Character, rhs: Character) -> Bool {
        return lhs.id == rhs.id
    }

    let id: Int
    let name: String
    let description: String
    let uriImage: Thumbnail
    let resourceURI: String
    let events: CollectionModel
    let urls: [UrlType]
    var hashValue: Int {
        return id.hashValue
    }
}

