//
//  EventDataParse.swift
//  MarvelHeroesGuide
//
//  Created by Tairus Djons on 27.07.2018.
//  Copyright © 2018 Tairus Djons. All rights reserved.
//

import Foundation
import SwiftyJSON

extension EventData {
    init?(json: JSON){
        self.data = DataObject(json: json["data"])!
        var events = [Event]()
        for (_, subJson) in json["data"]["results"] {
            events.append(Event(json: subJson)!)
        }
        self.results = events
    }
}
