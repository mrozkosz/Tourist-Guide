//
//  Api.swift
//  EstimoteAPP
//
//  Created by Mateusz on 02/09/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//


import Foundation
import Combine


enum Result<T, E> {
    case success(T)
    case failure(E)
}

enum ErrorResult: Error {
    case network(string: String)
    case parser(string: String)
    case custom(ErrorString)
    case errorMessages([ErrorMessages])
}

class AuthService: ObservableObject {
    var storage = LocalStorage()
    
    @Published var isRecoverPasswordSend:Bool = false
    @Published var errorMessage:[String] = []
    @Published var passwordHasBeenChanged:Bool = false
    
    
    func login(email:String, password:String, completion:  @escaping ((Result<LoginResponseModel, ErrorString>) -> Void)){
        
        let postString = "email=\(email)&password=\(password)";
        
        let url = URL(string: baseUrl + "/login")
        
        guard let requestUrl = url else { fatalError() }
        
        var request = URLRequest(url: requestUrl)
        
        request.httpMethod = "POST"
        
        request.httpBody = postString.data(using: String.Encoding.utf8);
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let dataResponse = data, error == nil else {return}
            
            if let httpResponse = response as? HTTPURLResponse {
                if(httpResponse.statusCode == 401){
                    completion(Result.failure(ErrorString(errors: "Nieprawidłowy login lub hasło.")))
                }
            }
            
            do{
                let decoder = JSONDecoder()
                
                let model:LoginResponseModel = try decoder.decode(LoginResponseModel.self, from: dataResponse)
                
                DispatchQueue.main.async {
                    completion(Result.success(model))
                }
                
            } catch _ {
                print("Decoder failed")
            }
            
        }.resume()
    }
    
    
    func me(token:String, completion:  @escaping ((Result<User, ErrorString>) -> Void)){
        
        let url = URL(string: baseUrl + "/me")
        
        guard let requestUrl = url else { fatalError() }
        
        var request = URLRequest(url: requestUrl)
        
        request.httpMethod = "GET"
        
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let dataResponse = data, error == nil else {return}
            
            if let httpResponse = response as? HTTPURLResponse {
                if(httpResponse.statusCode == 401){
                    completion(Result.failure(ErrorString(errors: "Unauthorized")))
                }
            }
            
            do{
                let decoder = JSONDecoder()
                
                let model:User = try decoder.decode(User.self, from: dataResponse)
                
                DispatchQueue.main.async {
                    completion(Result.success(model))
                }
                
            } catch _ {}
            
        }.resume()
    }
    
    func refreshToken(refreshToken:String, completion:  @escaping ((Result<LoginResponseModel, ErrorString>) -> Void)){
        
        let url = URL(string: baseUrl + "/refresh-token")
        guard let requestUrl = url else { fatalError() }
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        let postString = "token=\(refreshToken)";
        request.httpBody = postString.data(using: String.Encoding.utf8);
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let dataResponse = data, error == nil else {return}
            
            if let httpResponse = response as? HTTPURLResponse {
                if(httpResponse.statusCode == 401){
                    completion(Result.failure(ErrorString(errors: "Unauthorized")))
                }
            }
            
            do{
                let decoder = JSONDecoder()
                
                let model:LoginResponseModel = try decoder.decode(LoginResponseModel.self, from: dataResponse)
                
                DispatchQueue.main.async {
                    completion(Result.success(model))
                }
                
            } catch _ {}
            
        }.resume()
    }
    
    func loginByFacebook(token:String, completion:  @escaping ((Result<LoginResponseModel, ErrorString>) -> Void)){
        
        let url = URL(string: baseUrl + "/login/facebook")
        guard let requestUrl = url else { fatalError() }
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        let postString = "token=\(token)";
        request.httpBody = postString.data(using: String.Encoding.utf8);
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            
            guard let dataResponse = data, error == nil else {return}
            
            if let httpResponse = response as? HTTPURLResponse {
                if(httpResponse.statusCode == 401){
                    completion(Result.failure(ErrorString(errors: "Unauthorized")))
                }
            }
            
            do{
                let decoder = JSONDecoder()
                
                let model:LoginResponseModel = try decoder.decode(LoginResponseModel.self, from: dataResponse)
                
                DispatchQueue.main.async {
                    completion(Result.success(model))
                }
                
            } catch _ {}
        }.resume()
    }
    
    
    func signUp(user:RegisterUser, completion:  @escaping ((Result<User, [ErrorMessages]>) -> Void)){
        
        var jsonString = ""
        
        do {
            let jsonData = try JSONEncoder().encode(user)
            jsonString = String(data: jsonData, encoding: .utf8)!
            
        } catch {  }
        
        let url = URL(string: baseUrl + "/users")
        guard let requestUrl = url else { fatalError() }
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        
        // Set HTTP Request Header
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonString.data(using: String.Encoding.utf8);
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            let decoder = JSONDecoder()
            
            if let httpResponse = response as? HTTPURLResponse {
                self.errorMessage.removeAll()
                
                guard let dataResponse = data, error == nil else {return}
                
                if(httpResponse.statusCode == 201){
                    
                    do{
                        let model:User = try decoder.decode(User.self, from: dataResponse)
                        
                        DispatchQueue.main.async {
                            completion(Result.success(model))
                        }
                        
                    } catch _ {}
                    
                }else{
                    
                    do{
                        let model:[ErrorMessages] = try decoder.decode(ErrorModel.self, from: dataResponse).errors
                        
                        DispatchQueue.main.async {
                            completion(Result.failure(model))
                        }
                        
                    } catch _ {}
                    
                }
                
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

