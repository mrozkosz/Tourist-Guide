//
//  FavoritesViewModel.swift
//  EstimoteAPP
//
//  Created by Mateusz on 03/12/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//
import Foundation
import Combine
import SwiftUI

class FavoritesViewModel: ObservableObject {
    
    let didChange = PassthroughSubject<Void, Never>()

    @Published var favoritesModel = [FavoritesObjectModel]() {
        didSet { didChange.send() }
    }
    
    @Published var favorite:Int = 0
    
    public func getMethod() {
        FavoritesService().getAllData{ result in
            DispatchQueue.main.async {
                
                self.favoritesModel = result.map(FavoritesObjectModel.init)
            }
        }
    }
    
    public func getMethodByid(id:Int) {
        FavoritesService().getById(id: id){ result in
            DispatchQueue.main.async {
                self.favorite = result.isFavorite.intValue
            }
        }
    }
    
    public func updateMethod(id:Int) {
        FavoritesService().updateById(id: id){ result in
            DispatchQueue.main.async {
                self.favorite = result.isFavorite.intValue
            }
        }
    }
}

extension Bool {
    var intValue: Int {
        return self ? 1 : 0
    }
}

struct FavoritesObjectModel {
    
    var pleaces: FavoritesDataModel
    init(pleaces: FavoritesDataModel){
        self.pleaces = pleaces
    }
    
    var id: Int {
        return self.pleaces.id!
    }
    
    var pleace: Pleace {
        return self.pleaces.pleace
    }
}


