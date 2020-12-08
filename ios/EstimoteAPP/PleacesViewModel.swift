//
//  PleacesViewModel.swift
//  EstimoteAPP
//
//  Created by Mateusz on 26/11/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import Foundation
import Combine
import SwiftUI
import MapKit

class PleacesViewModel: ObservableObject {
    
    let didChange = PassthroughSubject<Void, Never>()
    @Published var pleacesModel = [PleacesObjectModel]() {
        didSet { didChange.send() }
    }
    
    @Published var photos = [[PhotosObjectModel]]() {
        didSet { didChange.send() }
    }
    
    @Published var tracks = [TracksObjectModel]() {
        didSet { didChange.send() }
    }
    
    @Published var photosCount:Int = 0
    
    @Published var singlePleaceModel:SinglePleaceDataModel?
    

    
    private var pleacesService: PleacesService!
    
    init() {
        self.pleacesService = PleacesService()
    }
    
    public func getDataByQuery(q:String) {
        self.pleacesService.getDdataByQuery(q: q){ result in
            DispatchQueue.main.async {
                
                self.pleacesModel = result.map(PleacesObjectModel.init)
            }
        }
    }
    
    public func getDataById(id:Int) {
        self.pleacesService.getDdataById(id: id){ result in
            DispatchQueue.main.async {
                
                self.singlePleaceModel = result.self
                
                let photos:[Photos] = result.self.photos
                
                self.photos =  photos.map(PhotosObjectModel.init).chunked(into: 2)
                
                self.photosCount = photos.count
                
                let tracks:[Tracks] = result.self.tracks
                
                self.tracks = tracks.map(TracksObjectModel.init)
           
                
            }
        }
        
    }
}

extension Array{
    func chunked(into size: Int)->[[Element]]{
        return stride(from: 0, to: count, by: size).map{
            Array(self[$0..<Swift.min($0 + size, count)])
        }
    }
}

struct PleacesObjectModel {
    
    var pleaces: PleacesDataModel
    init(pleaces: PleacesDataModel){
        self.pleaces = pleaces
    }
    
    var id: Int {
        return self.pleaces.id!
    }
    
    var coverImage: String {
        return self.pleaces.coverImage!
    }
    
    var description: String {
        return self.pleaces.description!
    }
    
    var name: String {
        return self.pleaces.name!
    }
    
    var location: String {
        return self.pleaces.location!
    }
}

struct PhotosObjectModel:Identifiable{
    var photos: Photos
    init(photos: Photos){
        self.photos = photos
    }
    
    var id: Int {
        return self.photos.id!
    }
    
    var url: String {
        return self.photos.url!
    }
    
    var description: String{
        return self.photos.description!
    }
}

struct TracksObjectModel:Identifiable{
    var tracks: Tracks
    init(tracks: Tracks){
        self.tracks = tracks
    }
    
    var id: Int {
        return self.tracks.id!
    }
    
    var url: String {
        return self.tracks.url!
    }
    
    var title: String{
        return self.tracks.title!
    }
}




