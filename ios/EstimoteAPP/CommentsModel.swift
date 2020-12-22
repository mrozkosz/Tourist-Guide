//
//  CommentsModel.swift
//  EstimoteAPP
//
//  Created by Mateusz on 21/12/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import Foundation

struct CommentsModel: Decodable {
    var comments: [commentsDataModel]
}

struct commentsDataModel: Decodable {
    let id:Int
    let message:String
    let user:User
    
    enum CodingKeys: String, CodingKey {
        case id, message, user
    }
}
