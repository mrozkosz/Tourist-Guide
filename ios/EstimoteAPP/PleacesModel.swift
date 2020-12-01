//
//  PleacesModel.swift
//  EstimoteAPP
//
//  Created by Mateusz on 26/11/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import Foundation

struct PleacesResponseModel: Decodable {
    let totalPages:Int
    let data :[PleacesDataModel]
}


struct PleacesDataModel: Decodable {
    let id:Int?
    let coverImage:String?
    let location:String?
    let name:String?
    let description:String?
 
    
    enum CodingKeys: String, CodingKey {
        case id, coverImage,location,name,description
    }
}

struct Pleace: Hashable, Decodable, Identifiable{
    let id:Int?
    let coverImage:String?
    let location:String?
    let name:String?
    let description:String?
}

//single pleace
struct SinglePleaceResponseModel: Decodable {
    let results: SinglePleaceDataModel
}

struct SinglePleaceDataModel: Decodable {
    let id:Int?
    let coverImage:String?
    let location:String?
    let name:String?
    let description:String?
    let photos:[Photos]
    let tracks:[Tracks]
}

struct Photos: Decodable, Identifiable {
    let id:Int?
    let url:String?
    let description:String?
    
    enum CodingKeys: String, CodingKey {
        case id, url, description
    }
}

struct Tracks: Decodable, Identifiable {
    let id:Int?
    let url:String?
    let title:String?
    
    enum CodingKeys: String, CodingKey {
        case id, url, title
    }
}
