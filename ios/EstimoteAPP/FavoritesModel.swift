//
//  FavoritesModel.swift
//  EstimoteAPP
//
//  Created by Mateusz on 03/12/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import Foundation

struct FavoritesResponseModel : Decodable {
    
    let data : [FavoritesDataModel]
}

struct FavoritesDataModel: Decodable {
    
    var id, pleaceId, userId : Int?
    var isFavorite:Bool
    var pleace: Pleace
    
    enum CodingKeys: String, CodingKey {
        case id, pleaceId, userId, isFavorite, pleace
        
    }
}

struct Favorite : Decodable {
    
    let isFavorite : Bool
}

