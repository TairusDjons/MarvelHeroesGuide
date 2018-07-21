//
//  Thumbnail.swift
//  MarvelHeroesGuide
//
//  Created by Tairus Djons on 20.07.2018.
//  Copyright © 2018 Tairus Djons. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Thumbnail {
    let path: String
    let exten: String
    init (_ path: String, _ exten: String) {
        self.path = path
        self.exten = exten
    }
}

extension Thumbnail {
    init?(json: JSON) {
        self.path = json["path"].stringValue
        self.exten = json["extension"].stringValue
    }
}
