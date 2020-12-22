//
//  HomePageModel.swift
//  EstimoteAPP
//
//  Created by Mateusz on 25/11/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import Foundation


struct HomePageResponseModel : Decodable {
    let daily : HomePagePleaceDetails
    let mostVisited: [HomePagePleaceDetails]
    let categorie: [Category]
    let restPleaces: [HomePagePleaceDetails]
}

struct HomePagePleaceDetails: Hashable, Decodable, Identifiable {
    var id:Int
    var coverImage:String
    var location:String
    var name:String
    
    enum CodingKeys: String, CodingKey {
        case id, coverImage, location, name
        
    }
}




