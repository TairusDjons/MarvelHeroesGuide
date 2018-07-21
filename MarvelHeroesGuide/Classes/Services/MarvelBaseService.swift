//
//  MarvelBaseService.swift
//  MarvelHeroesGuide
//
//  Created by Tairus Djons on 20.07.2018.
//  Copyright © 2018 Tairus Djons. All rights reserved.
//

import Foundation
import Alamofire

class MarvelBaseService: Requastable {
    func makeRequest(url: URLConvertible,
                     method: HTTPMethod,
                     parameters: Parameters? = nil,
                     encoding: ParameterEncoding? = JSONEncoding.default,
                     headers: HTTPHeaders? = nil,
                     responseType: ResponseType = .Json,
                     OnCompleted: ((Result<Any, Error>)->())? = {_ in }) {
        guard var params = parameters
            else {return}
        params["ts"] = Date.timeIntervalSinceReferenceDate.description
        params["apikey"] = APIKeysConverter.getKeys().PublicKey
        params["hash"] = APIKeysConverter.getHash()
        
        switch responseType {
        case .Json:
        Alamofire.request(url, method: method, parameters: params, encoding: encoding!, headers: headers).responseJSON {
            response in
            switch response.result {
            case .success(let value):
                OnCompleted!(.success(value))
            case .failure(let error):
                OnCompleted!(.error(error))
            }
            
        }
        case .Data:
        Alamofire.request(url, method: method, parameters: params, encoding: encoding!, headers: headers).responseData {
            response in
            switch response.result {
            case .success(let value):
                OnCompleted!(.success(value))
            case .failure(let error):
                OnCompleted!(.error(error))
            }
        
            }
    
        }
    }
}