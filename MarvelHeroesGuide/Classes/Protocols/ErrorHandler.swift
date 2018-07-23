//
//  APIErrorHandler.swift
//  MarvelHeroesGuide
//
//  Created by Tairus Djons on 23.07.2018.
//  Copyright © 2018 Tairus Djons. All rights reserved.
//

import Foundation

protocol ErrorHandler {
    func handleError(error: Error)
}
