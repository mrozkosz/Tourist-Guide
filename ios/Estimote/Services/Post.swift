//
//  Post.swift
//  Estimote
//
//  Created by Mateusz on 21/06/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import SwiftUI

struct Post: Codable, Identifiable{
    let id = UUID()
    let title:String
    
}
