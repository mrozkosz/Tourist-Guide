//
//  CategoryService.swift
//  EstimoteAPP
//
//  Created by Mateusz on 26/11/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import Foundation
import CoreLocation
import SwiftUI
import Combine

class CategoryService
{
    
    @State private var storage = LocalStorage()
    
    func getDataById(id:Int, completion: @escaping([CategoryDataModel]) ->())
    {
        
        
        let url = URL(string: baseUrl + "/category/" + String(id))
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
                let model:[CategoryDataModel] = try decoder.decode([CategoryDataModel].self, from: dataResponse)
                DispatchQueue.main.async {
                    completion(model)
                }
                
            } catch _ {
            }
        }
        task.resume()
    }
}
