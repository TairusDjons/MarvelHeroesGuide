//
//  EventResourceItemInit.swift
//  MarvelHeroesGuide
//
//  Created by Tairus Djons on 30.07.2018.
//  Copyright © 2018 Tairus Djons. All rights reserved.
//

import Foundation

extension Event {
    init(_ name: String,
         _ id: Int,
         _ description: String,
         _ thumbnail: Thumbnail? = nil,
         _ resourceURI: String? = nil,
         _ urls: [UrlType]? = nil,
         _ characters: ListModel<Character>? = nil) {
        self.name = name
        self.id = id
        self.description = description
        self.thumbnail = thumbnail!
        self.resourceURI = resourceURI!
        self.urls = urls!
        self.characters = characters!
    }
}

