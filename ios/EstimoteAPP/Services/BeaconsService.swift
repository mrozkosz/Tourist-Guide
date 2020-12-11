//
//  BeaconsService.swift
//  EstimoteAPP
//
//  Created by Mateusz on 02/12/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//
import Foundation
import CoreLocation
import SwiftUI
import Combine

class BeaconsService
{
    @State private var storage = LocalStorage()
    
    func getData(beaconsUUIDs:[String], completion: @escaping([PleacesDataModel]) ->())
    {
        
        let url = URL(string: baseUrl + "/beacons/detected")
        guard let requestUrl = url else { fatalError() }
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"

        request.setValue("Bearer \(storage.token)", forHTTPHeaderField: "Authorization")
        let params = "uuids=\(beaconsUUIDs.joined(separator: ", "))";
        request.httpBody = params.data(using: String.Encoding.utf8);
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
     
            guard let dataResponse = data,
                  error == nil else {
                return }
            
            do{
                
                let decoder = JSONDecoder()
          
                let model:[PleacesDataModel] = try decoder.decode(BeaconsResponseModel.self, from: dataResponse).pleaces
          
                DispatchQueue.main.async {
                    completion(model)
                }
                
            } catch _ {
            }
        }.resume()
        
        
    }
    
}

