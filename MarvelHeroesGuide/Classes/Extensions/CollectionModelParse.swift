//
//  CollectionModelParse.swift
//  MarvelHeroesGuide
//
//  Created by Tairus Djons on 23.07.2018.
//  Copyright © 2018 Tairus Djons. All rights reserved.
//

import Foundation
import SwiftyJSON

extension ListModel {
    init?(json: JSON) {
        self.available = json["available"].intValue
        self.collectionURI = json["collectionURI"].stringValue
        var tempItems = [T]()
        for (_, subJson) in json["items"] {
            tempItems.append(T(json: subJson)!)
        }
        self.items = tempItems
    }
}
