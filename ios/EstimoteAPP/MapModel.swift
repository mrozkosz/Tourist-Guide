//
//  MapModel.swift
//  EstimoteAPP
//
//  Created by Mateusz on 19/12/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import Foundation


struct MapResponseModel : Decodable {
    let totalPages : Int
    let data: [MapDataModel]
}

struct MapDataModel: Hashable, Decodable, Identifiable {
    var id:Int
    var coverImage:String
    var location:String
    var name:String
    var lat:Double
    var long:Double
    
    enum CodingKeys: String, CodingKey {
        case id, coverImage, location, name, lat, long
        
    }
}
