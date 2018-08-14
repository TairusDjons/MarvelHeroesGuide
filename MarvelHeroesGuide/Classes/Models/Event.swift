//
//  Event.swift
//  MarvelHeroesGuide
//
//  Created by Tairus Djons on 20.07.2018.
//  Copyright © 2018 Tairus Djons. All rights reserved.
//

import Foundation
struct Event: MarvelBaseObject {
    let name: String
    let id: Int
    let description: String
    let thumbnail: Thumbnail
    let resourceURI: String
    let characters: ListModel<Summary>
    let urls: [UrlType]
    
    
}
