//
//  PleacesService.swift
//  EstimoteAPP
//
//  Created by Mateusz on 26/11/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import Foundation
import CoreLocation
import SwiftUI
import Combine

class PleacesService
{
    
    @State private var storage = LocalStorage()
    
    func getDdataByQuery(q:String, completion: @escaping([PleacesDataModel]) ->())
    {
        let encodedQuery = q.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: baseUrl + "/pleaces?q=" + encodedQuery! + "&page=1")
        guard let requestUrl = url else { fatalError() }
        var request = URLRequest(url: requestUrl)
        request.setValue("Bearer \(storage.token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let dataResponse = data,
                  error == nil else {
                return }
            do{
                
                let decoder = JSONDecoder()
                
                let model:[PleacesDataModel] = try decoder.decode(PleacesResponseModel.self, from: dataResponse).data
                
                DispatchQueue.main.async {
                    completion(model)
                }
                
            } catch _ {
            }
        }
        task.resume()
    }
    
    
    func getDdataById(id:Int, completion: @escaping(SinglePleaceDataModel) ->())
    {
        
        let url = URL(string: baseUrl + "/pleaces/" + String(id))
        guard let requestUrl = url else { fatalError() }
        var request = URLRequest(url: requestUrl)
        request.setValue("Bearer \(storage.token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let dataResponse = data,
                  error == nil else {
                return }
            do{
                
                let decoder = JSONDecoder()
                
                let model:SinglePleaceDataModel = try decoder.decode(SinglePleaceResponseModel.self, from: dataResponse).results
                
                DispatchQueue.main.async {
                    completion(model)
                }
                
            } catch _ {
            }
        }
        task.resume()
    }
}
