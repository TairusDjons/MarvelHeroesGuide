//
//  CollectionModel.swift
//  MarvelHeroesGuide
//
//  Created by Tairus Djons on 23.07.2018.
//  Copyright © 2018 Tairus Djons. All rights reserved.
//

import Foundation
struct ListModel<T: ResourceItem> {
    let available: Int
    let collectionURI: String
    let items: [T]
}
