//
//  HomePageViewModel.swift
//  EstimoteAPP
//
//  Created by Mateusz on 25/11/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class HomePageViewModel: ObservableObject {
    
    let didChange = PassthroughSubject<Void, Never>()
    
    
    @Published var dailyModel: HomePagePleaceDetails?
    
    @Published var mostVisitedModel = [HomePagePleaceDetails](){
        didSet { didChange.send() }
    }
    
    @Published var categorieModel = [Category](){
        didSet { didChange.send() }
    }
    
    @Published var restPleaces = [HomePagePleaceDetails](){
        didSet { didChange.send() }
    }
    
    @Published var dataIsLoaded = false
    
    
    init(){
        getMethod()
    }
    
    public func getMethod() {
        HomePageService().getAllData{ result in
            DispatchQueue.main.async {
                
                self.dailyModel = result.daily
                
                self.mostVisitedModel = result.self.mostVisited
                
                self.categorieModel = result.self.categorie
                
                self.restPleaces = result.self.restPleaces
                
                self.dataIsLoaded = true
            
            }
            
            
        }
    }
}



