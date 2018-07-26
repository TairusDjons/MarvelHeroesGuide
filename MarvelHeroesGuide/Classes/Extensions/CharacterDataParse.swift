//
//  CharacterDataParse.swift
//  MarvelHeroesGuide
//
//  Created by Tairus Djons on 27.07.2018.
//  Copyright © 2018 Tairus Djons. All rights reserved.
//

import Foundation
import SwiftyJSON

extension CharacterData {
    init?(json: JSON){
        self.data = DataObject(json: json["data"])!
        var chars = [Character]()
        for (_, subJson) in json["data"]["results"] {
            chars.append(Character(json: subJson)!)
        }
        self.results = chars
    }
}
