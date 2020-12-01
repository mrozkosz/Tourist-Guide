//
//  ArticleModel.swift
//  EstimoteAPP
//
//  Created by Mateusz on 25/11/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import Foundation

// Mark - Response Model
struct ResponseModel : Decodable {
    
    let status: String?
    let copyright : String?
    let section : String?
    let last_updated : String?
    let num_results : Int?
    let results : [ArticleDataModel]
}

// Mark - Article Model
struct ArticleDataModel: Decodable {
    
    var section, subsection, title, abstract, url, byline, item_type  : String?
    var updated_date, created_date, published_date: String?
    var material_type_facet, kicker: String?
    var desfacet: [String]
    var orgfacet: [String]
    var perfacet: [String]
    var geofacet: [String]
    var multimedia: [MultimediaApiModel]?
    var short_url: String?
    
    enum CodingKeys: String, CodingKey {
        case section, subsection, title, abstract, url, byline, item_type
        case updated_date, created_date, published_date
        case desfacet = "des_facet"
        case orgfacet = "org_facet"
        case perfacet = "per_facet"
        case geofacet = "geo_facet"
        case multimedia, short_url
    }
}
// Mark - Multi Media Model
struct MultimediaApiModel: Decodable {
    var url: String?
    var format: String?
    var height: Int?
    var width: Int?
    var type: String?
    var subtype: String?
    var caption: String?
    var copyright: String?
}


