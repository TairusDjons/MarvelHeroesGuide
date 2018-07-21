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
                        offset: Int? = 0,
                        limit: Int? = 20,
                        OnCompletion: @escaping (Result<[Character],Error>)->()) {
        var params: [String: Any] = [
            "limit": limit!,
            "offset": offset!
        ]
        
        if let name = name {
            params["name"] = name
        }
        
        
        makeRequest(url: API.characters, method: .get, parameters: params, encoding: URLEncoding.default, responseType: .Json) {
            result in
            switch result {
            case .success(let value):
                let json = JSON(value)
                var characters = [Character]()
                let js = json["message"].stringValue
                for(_, subJson) in json["data"]["results"] {
                    guard let char = Character(json: subJson)
                        else {continue}
                    characters.append(char)
                }
                OnCompletion(.success(characters))
            case .error(let error):
                OnCompletion(.error(error))
            }
        }
    }
    
}
