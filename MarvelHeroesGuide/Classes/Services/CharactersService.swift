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

    
    func getCharactersBy(event uri: String,
                        offset: Int? = 0,
                        limit: Int? = 20,
                        OnCompletion: @escaping (Result<DataObject<Character>, Error>) -> ()) {
        //Get full info about event
        makeRequest(url: uri, method: .get, encoding: URLEncoding.default) {
            result in switch result {
            case .success(let result):
                let json = JSON(result)
                //We get only one event here, that's why we use results.first
                guard let data = DataObject<Event>(json: json["data"]),
                      let event = data.results.first
                    else {return}
                
                self.getCharacters(uri: event.characters.collectionURI, offset: offset, limit: limit) {
                    result in switch result {
                    case .success(let result):
                        OnCompletion(.success(result))
                    case .error(let error):
                        OnCompletion(.error(error))
                    }
                }
            case .error(let error):
                OnCompletion(.error(error))
            }
        }
    }
    
    //Very time consuming, not recommended for use
    
    func getAllConnectedCharactersTo(character: Character,
                                  offset: Int? = 0,
                                  limit: Int? = 20,
                                  OnCompletion: @escaping (Result<DataObject<Character>, Error>) -> ()) {
        let api = character.events.collectionURI
        
        let params: [String: Any] = [
            "limit": character.events.available
        ]
        makeRequest(url: api, method: .get, parameters: params, encoding:URLEncoding.default) {
            result in switch result {
            case .success(let result):
                let json = JSON(result)
                var counter = 0
                var dictionary = Dictionary<Character, Int>()
                var characters = [Character]()
                
                let eventData = DataObject<Event>(json: json)
                
                guard let events = eventData?.results
                    else {
                        return
                }
                
                if events.isEmpty {
                    OnCompletion(.success(DataObject<Character>()))
                    return
                }
                for event in events {
                    self.getCharactersBy(event: event.resourceURI,
                                        offset: offset,
                                        limit: limit) {
                        result in switch result {
                        case .success(let result):
                            OnCompletion(.success(result))
                            counter += 1
                        case .error(let error):
                            OnCompletion(.error(error))
                            return
                        }
                        if (counter == events.count) {
                            characters.append(contentsOf: dictionary.keys)
                            let dataObject = DataObject<Character>(offset: 0,
                                                                   limit: 0,
                                                                   total: characters.count,
                                                                   count: 0,
                                                                   collection: characters)
                            OnCompletion(.success(dataObject))
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
        let params: [String: Any] = [
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
                        OnCompletion: @escaping (Result<DataObject<Character>, Error>)->()) {

        let url: String
        if uri != nil {url = uri!}
        else {url = API.base + API.characters}
        
        var params: [String: Any] = [
            "limit": limit!,
            "offset": offset!
        ]
        
        if let name = name {
            params["nameStartsWith"] = name
        }
        
                
        makeRequest(url: url, method: .get, parameters: params, encoding: URLEncoding.default, responseType: .Json) {
            result in
            switch result {
            case .success(let value):
                let json = JSON(value)
                let data = DataObject<Character>(json: json["data"])!
                OnCompletion(.success(data))
            case .error(let error):
                OnCompletion(.error(error))
            }
        }
    }
    
}
