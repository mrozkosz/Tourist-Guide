//
//  AuthViewModel.swift
//  EstimoteAPP
//
//  Created by Mateusz on 09/12/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class AuthViewModel: ObservableObject {
    var storage = LocalStorage()
    @Published var isRegistered:Bool = false
    @Published var isLoggedUser:Bool = false
    @Published var error = ""
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var email = ""
    
    
    public func login(email:String, password:String) {
        AuthService().login(email: email, password: password){ result in
            
            DispatchQueue.main.async {
                switch result {
                case .success(let converter) :
                    
                    if(converter.refreshToken != ""){
                        self.isLoggedUser = true
                    }
                    
                case .failure( let e) :
                    self.isLoggedUser = false
                    self.error = e.errors
                    
                }
            }
        }
    }
    
    public func isLogged() {
        self.me()
    }
    
    public func refreshToken(){
        AuthService().refreshToken(refreshToken:self.storage.refreshToken){ result in
            DispatchQueue.main.async {
                switch result {
                case .success(let converter) :
                    self.isLoggedUser = true
                    self.storage.refreshToken = converter.refreshToken
                    self.storage.token = converter.token
                    self.storage.email = converter.user.email
                case .failure( _) :
                    self.isLoggedUser = false
                }
                
            }
        }
    }
    
    public func loginByFacebook(FBtoken:String) {
        AuthService().loginByFacebook(token: FBtoken){ result in
            
            DispatchQueue.main.async {
                switch result {
                case .success(let converter) :
                    
                    self.isLoggedUser = true
                    self.storage.refreshToken = converter.refreshToken
                    self.storage.token = converter.token
                    self.storage.email = converter.user.email
                case .failure( _) :
                    self.isLoggedUser = false
                    self.error = "Coś poszło nie tak"
                    
                }
            }
        }
    }
    
    public func me() {
        AuthService().me(token:self.storage.token){ result in
            DispatchQueue.main.async {
                switch result {
                case .success(let converter) :
                    
                    if(converter.email != ""){
                        self.isLoggedUser = true
                        self.firstName = converter.firstName
                        self.lastName = converter.lastName
                        self.email = converter.email
                    }
                case .failure( _) :
                    self.refreshToken()                    
                }
            }
        }
    }
    
    public func signUp(userData:RegisterUser) {
        AuthService().signUp(user: userData){ result in
            DispatchQueue.main.async {
                
                switch result {
                case .success(let converter) :
                    if(converter.email != ""){
                        self.isRegistered = true
                        print("1. \(self.isRegistered)")
                    }
                    
                case .failure(let error) :
                    self.isRegistered = false
                    self.error = error.first?.message ?? ""
                }
                
            }
        }
    }
}


