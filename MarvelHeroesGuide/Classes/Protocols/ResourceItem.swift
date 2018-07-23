//
//  CollectionItem.swift
//  MarvelHeroesGuide
//
//  Created by Tairus Djons on 23.07.2018.
//  Copyright © 2018 Tairus Djons. All rights reserved.
//

import Foundation
import SwiftyJSON
protocol ResourceItem {
    var resourceURI: String {get}
    var name: String {get}
}

