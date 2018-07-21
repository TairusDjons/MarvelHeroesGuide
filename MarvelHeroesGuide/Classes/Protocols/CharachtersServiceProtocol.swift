//
//  CharachtersServiceProtocol.swift
//  MarvelHeroesGuide
//
//  Created by Tairus Djons on 20.07.2018.
//  Copyright © 2018 Tairus Djons. All rights reserved.
//

import Foundation

protocol CharacterServiceProtocol {
    func getCharacters(name: String?,
                       offset: Int?,
                       limit: Int?,
                       OnCompletion: @escaping (Result<[Character],Error>)->())
}
