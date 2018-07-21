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
        self.title = json["title"].stringValue
        var tempChars = [Character]()
        for (_, subJson) in json["charachters"] {
            tempChars.append(Character(json: subJson)!)
        }
        self.charachters = tempChars
    }
}
