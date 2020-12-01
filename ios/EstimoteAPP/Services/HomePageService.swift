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
    func getAllData(completion: @escaping(HomePageResponseModel) ->())
    {
        let baseURL = URL(string: baseUrl + "/test")!
        let task = URLSession.shared.dataTask(with: baseURL) { (data, response, error) in
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


