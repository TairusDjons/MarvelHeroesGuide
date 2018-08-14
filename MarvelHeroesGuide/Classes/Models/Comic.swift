//
//  Comic.swift
//  MarvelHeroesGuide
//
//  Created by Tairus Djons on 06.08.2018.
//  Copyright © 2018 Tairus Djons. All rights reserved.
//

import Foundation

struct Comic: MarvelBaseObject {
    let id: Int
    let digitalId: Int
    let name: String
    let issueNumber: Double
    let variantDescription: String
    let isbn: String
    let upc: String
    let diamondCode: String
    let ean: String
    let issn: String
    let format: String
    let pageCount: String
    let images: [Thumbnail]
    let seriesSum: Summary
    let variants: [Summary]
    let collections: [Summary]
    let collectedIssues: [Summary]
    let dates: [DateModel]
    let prices: [PriceModel]
    let characters: ListModel<Summary>
    let description: String
    let resourceURI: String
    let urls: [UrlType]
    let thumbnail: Thumbnail
}
