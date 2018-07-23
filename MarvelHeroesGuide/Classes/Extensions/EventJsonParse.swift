//
//  EventJsonParse.swift
//  MarvelHeroesGuide
//
//  Created by Tairus Djons on 20.07.2018.
//  Copyright © 2018 Tairus Djons. All rights reserved.
//

import Foundation
import SwiftyJSON

extension Event {
    init?(json:JSON) {
        self.id = json["id"].intValue
        self.description = json["description"].stringValue
        self.thumbnail = Thumbnail(json: json["thumbnail"])!
        self.name = json["title"].stringValue
        self.resourceURI = json["resourceURI"].stringValue
        self.characters = CollectionModel(json: json["characters"])!
    }
}
