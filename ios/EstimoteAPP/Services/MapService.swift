//
//  MapService.swift
//  EstimoteAPP
//
//  Created by Mateusz on 19/12/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import Foundation
import CoreLocation
import SwiftUI
import Combine

class MapService
{
    @State private var storage = LocalStorage()
    
    func getAllData(completion: @escaping([MapDataModel]) ->())
    {
        
        let url = URL(string: baseUrl + "/pleaces?perPage=50")
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
                
                let model:[MapDataModel] = try decoder.decode(MapResponseModel.self, from: dataResponse).data
                
                DispatchQueue.main.async {
                    completion(model)
                }
                
            } catch _ {}
        }.resume()
    }
}
