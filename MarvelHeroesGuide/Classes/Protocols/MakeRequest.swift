//
//  MakeRequest.swift
//  MarvelHeroesGuide
//
//  Created by Tairus Djons on 19.07.2018.
//  Copyright © 2018 Tairus Djons. All rights reserved.
//

import Foundation
import Alamofire

protocol Requastable {
    func makeRequest(url: URLConvertible,
                     method: HTTPMethod,
                     parameters: Parameters?,
                     encoding: ParameterEncoding?,
                     headers: HTTPHeaders?,
                     responseType: ResponseType,
                     OnCompleted: ((Result<Any, Error>)->())?)
}


extension Requastable {
    func makeRequest(url: URLConvertible,
                     method: HTTPMethod,
                     parameters: Parameters? = nil,
                     encoding: ParameterEncoding? = JSONEncoding.default,
                     headers: HTTPHeaders? = nil,
                     responseType: ResponseType = .Json,
                     OnCompleted: ((Result<Any, Error>)->())?) {
        Alamofire.request(url, method: method, parameters: parameters, encoding: encoding!, headers: headers).responseData() {
            response in
            switch response.result {
            case .success(let result):
                OnCompleted!(.success(result))
            case .failure(let error):
                OnCompleted!(.error(error))
            }
        }
    }
}
