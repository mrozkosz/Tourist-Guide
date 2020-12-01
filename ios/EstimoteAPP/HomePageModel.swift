//
//  HomePageModel.swift
//  EstimoteAPP
//
//  Created by Mateusz on 25/11/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import Foundation


struct HomePageResponseModel : Decodable {
    let daily : Pleace
    let mostVisited: [Pleace]
    let categorie: [Category]
}
 
struct HomePageDataModel: Decodable {
    var id = UUID()
    let daily:Pleace
    let mostVisited:[Pleace]
    let categorie:[Category]
    
    enum CodingKeys: String, CodingKey {
        case id,daily,mostVisited, categorie
    }
}

struct HomePageStructure: Hashable, Decodable, Identifiable{
    var id = UUID()
    let daily:Pleace
    let mostVisited:[Pleace]
    let categorie:[Category]
}




