//
//  ResultType.swift
//  MarvelHeroesGuide
//
//  Created by Tairus Djons on 19.07.2018.
//  Copyright © 2018 Tairus Djons. All rights reserved.
//

import Foundation

enum Result<T, T1> {
    case success(T)
    case error(T1)
}
