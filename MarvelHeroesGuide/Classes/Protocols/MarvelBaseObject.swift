//
//  MarvelBaseObject.swift
//  MarvelHeroesGuide
//
//  Created by Tairus Djons on 26.07.2018.
//  Copyright © 2018 Tairus Djons. All rights reserved.
//

import Foundation
import SwiftyJSON
protocol MarvelBaseObject: ResourceItem, jsonParsable {
    var id: Int { get }
    var name: String { get }
    var resourceURI: String { get }
    var urls: [UrlType] { get }
    var thumbnail: Thumbnail { get }
    var description: String { get }
}

extension MarvelBaseObject {
    init?(json: JSON) {
        self.init(json: json)
    }
}
