//
//  MapViewModel.swift
//  EstimoteAPP
//
//  Created by Mateusz on 19/12/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import Foundation
import Combine
import SwiftUI


class MapViewModel: ObservableObject {
    
    let didChange = PassthroughSubject<Void, Never>()

    @Published var mapDataModels = [MapObjectModel]() {
        didSet { didChange.send() }
    }
    
    init() {
        self.getAll()
    }
    
    private func getAll() {
        MapService().getAllData{ result in
            DispatchQueue.main.async {
                self.mapDataModels = result.map(MapObjectModel.init)
            }
        }
    }
}

struct MapObjectModel {
    
    var mapItem: MapDataModel
    init(mapItem: MapDataModel){
        self.mapItem = mapItem
    }
    
    var id: Int {
        return self.mapItem.id
    }
    
    var coverImage: String {
        return self.mapItem.coverImage
    }
    
    var location: String {
        return self.mapItem.location
    }
    
    var name: String {
        return self.mapItem.name
    }
    
    var lat: Double {
        return self.mapItem.lat
    }
    
    var long: Double {
        return self.mapItem.long
    }
}
