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
    func getDataById(id:Int, completion: @escaping([CategoryDataModel]) ->())
    {
        let baseURL = URL(string: baseUrl + "/category/" + String(id))!
        let task = URLSession.shared.dataTask(with: baseURL) { (data, response, error) in
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
