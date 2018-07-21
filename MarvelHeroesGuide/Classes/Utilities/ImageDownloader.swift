//
//  ImageDownloader.swift
//  MarvelHeroesGuide
//
//  Created by Tairus Djons on 21.07.2018.
//  Copyright © 2018 Tairus Djons. All rights reserved.
//

import Foundation
import Alamofire

class ImageDownloader: Requastable {
        
    func downloadImage(path: String, OnCompleted: @escaping (UIImage)->()) {
        makeRequest(url:path, method: .get) {
            result in
            switch result {
            case .success(let result):
                let data = result as! Data
                OnCompleted(UIImage(data: data)!)
            case .error(let error):
                print(error)
            }
        }
    }
}
