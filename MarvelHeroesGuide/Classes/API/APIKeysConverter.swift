//
//  APIKeysConverter.swift
//  MarvelHeroesGuide
//
//  Created by Tairus Djons on 19.07.2018.
//  Copyright © 2018 Tairus Djons. All rights reserved.
//

import Foundation
import CryptoSwift

struct Keys {
    let PublicKey: String?
    let PrivateKey: String?
}


public class APIKeysConverter {
    static func getHash() -> String {
        let ts = NSDate.timeIntervalSinceReferenceDate.description
        let keys = getKeys()
        guard let publicKey = keys.PublicKey,
              let privateKey = keys.PrivateKey
        else { return "" }
        let hash = "\(ts)\(privateKey)\(publicKey)".md5()
        return hash
    }
    
    static func getKeys() -> Keys {
        guard let dict = Bundle.main.path(forResource: "APIkeys", ofType: "plist"),
              let data = NSDictionary(contentsOfFile: dict)
            else { return Keys(PublicKey: "", PrivateKey: "") }
        return Keys(PublicKey: data["publicKey"] as? String, PrivateKey: data["privateKey"] as? String)
    }
}
