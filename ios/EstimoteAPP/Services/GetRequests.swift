//
//  Api.swift
//  EstimoteAPP
//
//  Created by Mateusz on 02/09/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import Foundation

struct Post: Hashable, Decodable, Identifiable{
    let id:Int
    let categorieId:Int
    let pleace:Pleace
    
}

struct CategoryStructure: Hashable, Decodable, Identifiable{
    let id:Int
    let pleace:Pleace
}


class GetRequests: ObservableObject {
    @Published var homePageData = [HomePageStructure]()
    @Published var categoryByIdData = [CategoryStructure]()
    @Published var dataIsLoaded: Bool = false
    
   
    
    func homePage(){
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true
        config.timeoutIntervalForResource = 60
        
        let url = URL(string: baseUrl + "/test")
        URLSession(configuration: config).dataTask(with: url!) { (data, respons, error) in
            guard let unwrappedData = data else { print("Error unwrapping data"); return }
            
            do {
                
                let decodedData  = try JSONDecoder().decode([HomePageStructure].self, from: unwrappedData)
                DispatchQueue.main.async {
                    self.homePageData = decodedData
                    self.dataIsLoaded = true
                }
                
            } catch {
                print("Could not get API data. \(error), \(error.localizedDescription)")
            }
        }.resume()
    }
    
    func categoryById(id:Int){
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true
        config.timeoutIntervalForResource = 60
        
        let url = URL(string: baseUrl + "/category/\(id)")
        URLSession(configuration: config).dataTask(with: url!) { (data, respons, error) in
            guard let unwrappedData = data else { print("Error unwrapping data"); return }
            
            do {
                
                let decodedData  = try JSONDecoder().decode([CategoryStructure].self, from: unwrappedData)
                
                DispatchQueue.main.async {
                    self.categoryByIdData = decodedData
                    self.dataIsLoaded = true
                }
                
            } catch {
                print("Could not get API data. \(error), \(error.localizedDescription)")
            }
        }.resume()
    }
    
    
    func getPosts(){
        let url = URL(string: "https://jsonplaceholder.typicode.com/todos")
        guard let requestUrl = url else { fatalError() }
        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        
        // HTTP Request Parameters which will be sent in HTTP Request Body
        let postString = "title=My urgent task&image=https://via.placeholder.com/150/f66b97";
        // Set HTTP Request Body
        request.httpBody = postString.data(using: String.Encoding.utf8);
        // Perform HTTP Request
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // Check for Error
            if let error = error {
                print("Error took place \(error)")
                return
            }
            
            // Convert HTTP Response Data to a String
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                print("Response data string:\n \(dataString)")
            }
        }.resume()
        
    }
    
    
    
}

