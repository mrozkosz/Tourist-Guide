//
//  CategoryModel.swift
//  EstimoteAPP
//
//  Created by Mateusz on 26/11/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import Foundation

struct CategoryDataModel: Decodable {
    let id:Int?
    let categorieId:Int?
    let pleaceId:Int?
    let pleace:Pleace?
    
    enum CodingKeys: String, CodingKey {
        case id, categorieId, pleaceId, pleace
    }
}

struct Category: Hashable, Codable, Identifiable{
    var id:Int?
    let name:String?
    
}
