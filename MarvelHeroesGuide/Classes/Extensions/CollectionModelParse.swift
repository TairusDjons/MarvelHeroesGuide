//
//  CollectionModelParse.swift
//  MarvelHeroesGuide
//
//  Created by Tairus Djons on 23.07.2018.
//  Copyright © 2018 Tairus Djons. All rights reserved.
//

import Foundation
import SwiftyJSON

extension CollectionModel {
    init?(json: JSON) {
        self.available = json["available"].intValue
        self.collectionURI = json["collectionURI"].stringValue
        var tempItems = [Item]()
        for (_, subJson) in json["items"] {
            tempItems.append(Item(json: subJson)!)
        }
        self.items = tempItems
    }
}
