//
//  CharachtersService.swift
//  MarvelHeroesGuide
//
//  Created by Tairus Djons on 20.07.2018.
//  Copyright © 2018 Tairus Djons. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class CharacterService: MarvelBaseService, CharacterServiceProtocol {
    func getCharacters( name: String? = nil,
                        offset: Int? = 20,
                        limit: Int? = 100,
                        OnCompletion: @escaping (Result<[Character],Error>)->()) {
        let params: [String: Any] = [
            "nameStartWith": name!,
            "limit": limit!,
            "offset": offset!
        ]
        makeRequest(url: API.characters, method: .get, parameters: params, responseType: .Json) {
            result in
            switch result {
            case .success(let result):
                let json = JSON(result)
                var charachters = [Character]()
                for(_, subJson) in json["data"]["results"] {
                    guard let char = Character(json: subJson)
                        else {continue}
                    charachters.append(char)
                }
                OnCompletion(.success(charachters))
            case .error(let error):
                OnCompletion(.error(error))
            }
        }
    }
    
}
