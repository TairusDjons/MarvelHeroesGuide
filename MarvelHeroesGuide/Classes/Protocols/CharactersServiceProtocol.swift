//
//  CharachtersServiceProtocol.swift
//  MarvelHeroesGuide
//
//  Created by Tairus Djons on 20.07.2018.
//  Copyright © 2018 Tairus Djons. All rights reserved.
//

import Foundation

protocol CharacterServiceProtocol {
    func getCharacters(uri: String?,
                       name: String?,
                       offset: Int?,
                       limit: Int?,
                       OnCompletion: @escaping (Result<DataObject<Character>, Error>)->())
    
    func getTotalCharCount(OnCompletion: @escaping (Result<Int, Error>)->())
    
    
    func getCharactersBy(event uri: String,
                         offset: Int?,
                         limit: Int?,
                         OnCompletion: @escaping (Result<DataObject<Character>, Error>)->())
    
    
    func getAllConnectedCharactersTo(character: Character,
                                  offset: Int?,
                                  limit: Int?,
                                  OnCompletion: @escaping (Result<DataObject<Character>, Error>)->())
}

