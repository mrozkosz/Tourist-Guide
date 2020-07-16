//
//  Api.swift
//  Estimote
//
//  Created by Mateusz on 21/06/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import SwiftUI

class API: ObservableObject {
    func get() {
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")
        
        URLSession.shared.dataTask(with: url!) { (data, respons, error) in
            guard let unwrappedDAta = data else { print("Error unwrapping data"); return }
            
            do {
                
                
                let posts = try JSONDecoder().decode([Post].self, from: unwrappedDAta)
                
                print(posts)
                
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
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // Check for Error
            if let error = error {
                print("Error took place \(error)")
                return
            }
            
            // Convert HTTP Response Data to a String
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                print("Response data string:\n \(dataString)")
            }
        }
        task.resume()
        
    }
    
    
    
}
