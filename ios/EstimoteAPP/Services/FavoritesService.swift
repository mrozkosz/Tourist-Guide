//
//  FavoritesService.swift
//  EstimoteAPP
//
//  Created by Mateusz on 03/12/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import Foundation
import CoreLocation
import SwiftUI
import Combine

class FavoritesService
{
    @State private var storage = LocalStorage()
    
    func getAllData(completion: @escaping([FavoritesDataModel]) ->())
    {
        let url = URL(string: baseUrl + "/favorites")
        guard let requestUrl = url else { fatalError() }
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        
        request.setValue("Bearer \(storage.token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let dataResponse = data,
                  error == nil else {
                return }
            
            do{
                
                let decoder = JSONDecoder()
                
                let model:[FavoritesDataModel] = try decoder.decode(FavoritesResponseModel.self, from: dataResponse).data
                
                DispatchQueue.main.async {
                    completion(model)
                }
                
            } catch _ {}
        }.resume()
    }
    
    func getById(id:Int, completion: @escaping(Favorite) ->())
    {
        
        let url = URL(string: baseUrl + "/favorites/\(id)")
        guard let requestUrl = url else { fatalError() }
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        
        request.setValue("Bearer \(storage.token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let dataResponse = data,
                  error == nil else {
                return }
            
            do{
                
                let decoder = JSONDecoder()
                
                let model:Favorite = try decoder.decode(Favorite.self, from: dataResponse)
                
                DispatchQueue.main.async {
                    completion(model)
                }
                
            } catch _ {}
        }.resume()
        
    }
    
    func updateById(id:Int, completion: @escaping(Favorite) ->())
    {
        
        let url = URL(string: baseUrl + "/favorites/\(id)")
        guard let requestUrl = url else { fatalError() }
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "PUT"
        
        request.setValue("Bearer \(storage.token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let dataResponse = data,
                  error == nil else {
                return }
            
            do{
                
                let decoder = JSONDecoder()
                
                let model:Favorite = try decoder.decode(Favorite.self, from: dataResponse)
                
                DispatchQueue.main.async {
                    completion(model)
                }
                
            } catch _ {}
        }.resume()
        
    }
    
}

