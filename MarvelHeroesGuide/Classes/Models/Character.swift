//
//  Charachter.swift
//  MarvelHeroesGuide
//
//  Created by Tairus Djons on 20.07.2018.
//  Copyright © 2018 Tairus Djons. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Character {
    let id: Int
    let name: String
    let description: String
    let uriImage: Thumbnail
    let events: [Event]
}

