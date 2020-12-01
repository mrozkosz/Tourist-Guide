//
//  Api.swift
//  EstimoteAPP
//
//  Created by Mateusz on 02/09/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import Foundation

struct AuthStructure: Hashable, Decodable{
    let token:String
    let refreshToken:String
    let user:UserStructure
}

struct UserStructure: Hashable, Decodable, Identifiable{
    let id:Int
    let email:String
    let firstName:String
    let lastName:String
}

class AuthService: ObservableObject {
    var storage = LocalStorage()
    @Published var UserData = [AuthStructure]()
    @Published var isLoggedUser:Bool = false
    @Published var isRecoverPasswordSend:Bool = false
    @Published var errorMessage:[String] = []
    @Published var passwordHasBeenChanged:Bool = false
    
    
    func login(email:String, password:String){
        let url = URL(string: baseUrl + "/login")
        guard let requestUrl = url else { fatalError() }
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        let postString = "email=\(email)&password=\(password)";
        request.httpBody = postString.data(using: String.Encoding.utf8);
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            DispatchQueue.main.sync {
                if let httpResponse = response as? HTTPURLResponse {
                    self.errorMessage.removeAll()
                    
                    print(httpResponse.statusCode)
                    
                    if(httpResponse.statusCode != 200){
                        self.errorMessage.append("Nieprawidłowy login lub hasło.")
                    }
                }
            }
            
            
            guard let unwrappedData = data else { print("Error unwrapping data"); return }
            
            
            do {
                let decodedData  = try JSONDecoder().decode(AuthStructure.self, from: unwrappedData)
                
                DispatchQueue.main.sync {
                    if(decodedData.token != ""){
                        self.isLoggedUser = true
                        self.storage.token = decodedData.token
                        self.storage.refreshToken = decodedData.refreshToken
                    }
                }
                
            } catch {
                print("Could not get API data.")
            }
        }.resume()
    }
    
    
    func loginByFacebook(token:String){
        let url = URL(string: baseUrl + "/login/facebook")
        guard let requestUrl = url else { fatalError() }
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        let postString = "token=\(token)";
        request.httpBody = postString.data(using: String.Encoding.utf8);
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            DispatchQueue.main.sync {
                if let httpResponse = response as? HTTPURLResponse {
                    self.errorMessage.removeAll()
                    
                    if(httpResponse.statusCode != 200){
                        self.errorMessage.append("Ups, coś poszło nie tak.")
                    }
                }
            }
            
            guard let unwrappedData = data else { print("Error unwrapping data"); return }
            
            do {
                let decodedData  = try JSONDecoder().decode(AuthStructure.self, from: unwrappedData)
                
                DispatchQueue.main.sync {
                    if(decodedData.token != ""){
                        self.isLoggedUser = true
                        self.storage.token = decodedData.token
                        self.storage.refreshToken = decodedData.refreshToken
                        self.UserData.removeAll()
                        self.UserData.append(AuthStructure(token: decodedData.token, refreshToken: decodedData.refreshToken,
                                                           user: UserStructure(id: decodedData.user.id, email: decodedData.user.email,
                                                                               firstName: decodedData.user.firstName, lastName: decodedData.user.lastName)))
                    }
                }
                
            } catch {
                print("Could not get API data.")
            }
        }.resume()
    }
    
    
    func refreshToken(refreshToken:String){
        
        let url = URL(string: baseUrl + "/refresh-token")
        guard let requestUrl = url else { fatalError() }
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        let postString = "token=\(refreshToken)";
        request.httpBody = postString.data(using: String.Encoding.utf8);
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let unwrappedData = data else { print("Error unwrapping data"); return }
            
            do {
                let decodedData  = try JSONDecoder().decode(AuthStructure.self, from: unwrappedData)
                
                DispatchQueue.main.async {
                    if(decodedData.token != ""){
                        self.isLoggedUser = true
                        self.storage.token = decodedData.token
                        self.storage.refreshToken = decodedData.refreshToken
                    }
                }
                
            } catch {
                print("Could not get API data. \(error), \(error.localizedDescription)")
            }
        }.resume()
        
        
    }
    
    func recoverPassword(email:String){
        let url = URL(string: baseUrl + "/recover-password")
        guard let requestUrl = url else { fatalError() }
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        let postString = "email=\(email)";
        request.httpBody = postString.data(using: String.Encoding.utf8);
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            DispatchQueue.global(qos: .userInteractive).sync {
                if let httpResponse = response as? HTTPURLResponse {
                    self.errorMessage.removeAll()
                    if(httpResponse.statusCode == 204){
                        self.isRecoverPasswordSend = true
                    }else{
                        self.errorMessage.append("Nieprawidłowy adres email.")
                    }
                }
            }
            
        }.resume()
    }
    
    
    func setNewPassword(hash:String, password:String){
        
        let url = URL(string: baseUrl + "/recover-password/\(hash)")
        guard let requestUrl = url else { fatalError() }
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        let postString = "password=\(password)&passwordRepeat=\(password)";
        request.httpBody = postString.data(using: String.Encoding.utf8);
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            DispatchQueue.main.async {
                if let httpResponse = response as? HTTPURLResponse {
                    self.errorMessage.removeAll()
                    
                    if(httpResponse.statusCode == 204){
                        self.passwordHasBeenChanged = true
                    }
                    
                    if(httpResponse.statusCode == 401){
                        self.errorMessage.append("Nieprawidłowy kod.")
                    }
                    
                    if(httpResponse.statusCode == 400){
                        self.errorMessage.append("Hasło musi mieć od 6 do 12 znaków")
                    }
                    
                    
                }
            }
            
        }.resume()
    }
    
}

