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
        self.uriImage = Thumbnail(json: json["thumbnail"])!
        var tempEvents = [Event]()
        for (_, subJson) in json["events"] {
            tempEvents.append(Event(json: subJson)!)
        }
        self.events = tempEvents
    }
}

