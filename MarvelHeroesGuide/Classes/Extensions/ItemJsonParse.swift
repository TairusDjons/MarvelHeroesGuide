//
//  ItemJsonParse.swift
//  MarvelHeroesGuide
//
//  Created by Tairus Djons on 23.07.2018.
//  Copyright © 2018 Tairus Djons. All rights reserved.
//

import Foundation
import SwiftyJSON

extension Summary {
    init?(json: JSON){
        self.name = json["name"].stringValue
        self.resourceURI = json["resourceURI"].stringValue
    }
}
