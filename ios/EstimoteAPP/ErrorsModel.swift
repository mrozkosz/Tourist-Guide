//
//  ErrorsModel.swift
//  EstimoteAPP
//
//  Created by Mateusz on 11/12/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import Foundation


struct ErrorModel:Decodable{
    let errors:[ErrorMessages]
}

struct ErrorMessages: Decodable {

    var message:String?
    
    enum CodingKeys: String, CodingKey {
        case message
        
    }
}

struct ErrorString:Decodable{
    let errors:String
}




