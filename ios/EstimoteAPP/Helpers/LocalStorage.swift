//
//  UserSettings.swift
//  EstimoteAPP
//
//  Created by Mateusz on 20/09/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import Foundation
import Combine

class LocalStorage: ObservableObject {
  @Published var email: String {
       didSet {
           UserDefaults.standard.set(email, forKey: "email")
       }
   }
   
   @Published var token: String {
       didSet {
           UserDefaults.standard.set(token, forKey: "token")
       }
   }
   
   @Published var refreshToken: String {
       didSet {
           UserDefaults.standard.set(refreshToken, forKey: "refreshToken")
       }
   }
    
   
   init() {
       self.email = UserDefaults.standard.object(forKey: "email") as? String ?? ""
       self.token = UserDefaults.standard.object(forKey: "token") as? String ?? ""
       self.refreshToken = UserDefaults.standard.object(forKey: "refreshToken") as? String ?? ""
   }
}
