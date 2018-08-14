//
//  DataObjectParse.swift
//  MarvelHeroesGuide
//
//  Created by Tairus Djons on 27.07.2018.
//  Copyright © 2018 Tairus Djons. All rights reserved.
//

import Foundation
import SwiftyJSON

extension DataModel {
    init?(json:JSON) {
        self.count = json["count"].intValue
        self.limit = json["limit"].intValue
        self.offset = json["offset"].intValue
        self.total = json["total"].intValue
        var collection = [T]()
        for (_, subJson) in json["results"] {
            collection.append(T(json: subJson)!)
        }
        self.results = collection
    }
}



