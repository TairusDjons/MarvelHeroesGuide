//
//  Url.swift
//  MarvelHeroesGuide
//
//  Created by Tairus Djons on 24.07.2018.
//  Copyright © 2018 Tairus Djons. All rights reserved.
//

import Foundation
import SwiftyJSON
struct UrlType {
    let type: String
    let url: String
}

extension UrlType {
    init?(json: JSON) {
        self.type = json["type"].stringValue
        self.url = json["url"].stringValue
    }
}
