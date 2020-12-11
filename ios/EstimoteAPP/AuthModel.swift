//
//  AuthModel.swift
//  EstimoteAPP
//
//  Created by Mateusz on 09/12/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import Foundation

struct LoginResponseModel : Decodable {
    let token:String
    let refreshToken:String
    let user : User
}

struct User : Decodable {
    let email:String
    let firstName:String
    let lastName:String
}

struct RegisterUser:Codable{
    let firstName:String
    let lastName:String
    let email:String
    let password:String
}



