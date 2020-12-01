//
//  Webservices.swift
//  EstimoteAPP
//
//  Created by Mateusz on 25/11/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import Foundation
import CoreLocation
import SwiftUI
import Combine

class Webservice
{
    // Mark - API Call
    func getAllArticles(completion: @escaping([ArticleDataModel]) ->())
    {
        let baseURL = URL(string: Constants.apiUrl + Constants.versionApi + appSecretKey)!
        let task = URLSession.shared.dataTask(with: baseURL) { (data, response, error) in
        guard let dataResponse = data,
                  error == nil else {
                  return }
            do{
                
                let decoder = JSONDecoder()
                let model:[ArticleDataModel] = try decoder.decode(ResponseModel.self, from:
                    dataResponse).results 
                DispatchQueue.main.async {
                   completion(model)
                }
              
            } catch _ {
           }
        }
        task.resume()
    }
}

