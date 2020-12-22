//
//  HomePageService.swift
//  EstimoteAPP
//
//  Created by Mateusz on 17/11/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import Foundation
import CoreLocation
import SwiftUI
import Combine

class HomePageService
{
    @State private var storage = LocalStorage()
    
    func getAllData(completion: @escaping(HomePageResponseModel) ->())
    {
     
        
        let url = URL(string: baseUrl + "/home")
        
        guard let requestUrl = url else { fatalError() }
        
        var request = URLRequest(url: requestUrl)
        
        request.httpMethod = "GET"

        request.setValue("Bearer \(storage.token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        guard let dataResponse = data,
                  error == nil else {
                  return }
            do{
                
                let decoder = JSONDecoder()
               
                let model:HomePageResponseModel = try decoder.decode(HomePageResponseModel.self, from: dataResponse)
                DispatchQueue.main.async {
                   completion(model)
                }
              
            } catch _ {
           }
        }
        task.resume()
    }
}


