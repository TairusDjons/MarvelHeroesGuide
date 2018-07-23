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

private enum localError: Error {
    case cannotCreateChar
}

class CharacterService: MarvelBaseService, CharacterServiceProtocol {
    
    
    func getCharactersByEvent(event: Event,
                              offset: Int? = 0,
                              limit: Int? = 20,
                              OnCompletion: @escaping (Result<[Character], Error>) -> ()) {
        let uri = event.characters.collectionURI
        getCharacters(uri: uri, offset: offset, limit: limit) {
            result in switch result {
            case .success(let result):
                OnCompletion(.success(result))
            case .error(let error):
                OnCompletion(.error(error))
            }
        }
    }
    
    
    
    
    func getConnectedCharactersTo(character: Character,
                                  offset: Int? = 0,
                                  limit: Int? = 20,
                                  OnCompletion: @escaping (Result<[Character], Error>) -> ()) {
        let api = character.events.collectionURI
        
        makeRequest(url: api, method: .get, encoding:URLEncoding.default) {
            result in switch result {
            case .success(let result):
                let json = JSON(result)
                var counter = 0
                var dictionary = Dictionary<Character, Int>()
                var characters = [Character]()
                var events = [Event]()
                
                for(_, subJson) in json["data"]["results"] {
                    guard let event = Event(json: subJson)
                        else {continue}
                    events.append(event)
                }
                for event in events {
                    self.getCharactersByEvent(event: event,
                                              offset: offset,
                                              limit: limit) {
                        result in switch result {
                        case .success(let result):
                            for char in result {
                                if dictionary[char] == nil {
                                    dictionary[char] = 1
                                }
                            }
                            counter += 1
                        case .error(let error):
                            OnCompletion(.error(error))
                            return
                        }
                        if (counter == events.count) {
                            characters.append(contentsOf: dictionary.keys)
                            OnCompletion(.success(characters))
                            return
                        }
                    }
                }

            case .error(let error):
                OnCompletion(.error(error))
            }
        }
    }
    
    
    
    func getTotalCharCount(OnCompletion: @escaping (Result<Int, Error>) -> ()) {
        var params: [String: Any] = [
            "limit": 0
        ]
        makeRequest(url: API.base + API.characters, method: .get, parameters: params, encoding: URLEncoding.default) {
            result in switch result {
            case .success(let value):
                let json = JSON(value)
                let total = json["data"]["total"].intValue
                OnCompletion(.success(total))
            case .error(let error):
                OnCompletion(.error(error))
            }
        }
    }
    
    
    
    func getCharacters( uri: String? = nil,
                        name: String? = nil,
                        offset: Int? = 0,
                        limit: Int? = 20,
                        OnCompletion: @escaping (Result<[Character],Error>)->()) {

        let url: String
        if uri != nil {url = uri!}
        else {url = API.base + API.characters}
        
        var params: [String: Any] = [
            "limit": limit!,
            "offset": offset!
        ]
        
        if let name = name {
            params["name"] = name
        }
        
                
        makeRequest(url: url, method: .get, parameters: params, encoding: URLEncoding.default, responseType: .Json) {
            result in
            switch result {
            case .success(let value):
                let json = JSON(value)
                var characters = [Character]()
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
