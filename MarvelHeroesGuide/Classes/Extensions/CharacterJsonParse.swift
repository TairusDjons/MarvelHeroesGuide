//
//  CharachterJsonParse.swift
//  MarvelHeroesGuide
//
//  Created by Tairus Djons on 20.07.2018.
//  Copyright © 2018 Tairus Djons. All rights reserved.
//

import Foundation
import SwiftyJSON

extension Character {
    init?(json: JSON) {
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.description = json["description"].stringValue
        self.thumbnail = Thumbnail(json: json["thumbnail"])!
        self.resourceURI = json["resourceURI"].stringValue
        self.events = CollectionModel(json: json["events"])!
        var tempUrls = [UrlType]()
        for (_, subJson) in json["urls"] {
            tempUrls.append(UrlType(json: subJson)!)
        }
        self.urls = tempUrls
    }
}

