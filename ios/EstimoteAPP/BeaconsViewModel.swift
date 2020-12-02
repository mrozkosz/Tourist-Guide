//
//  BeaconsModel.swift
//  EstimoteAPP
//
//  Created by Mateusz on 02/12/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import Foundation
import Combine
import SwiftUI
import EstimoteProximitySDK

class BeaconsViewModel:NSObject,ObservableObject{
    
    static let shared = BeaconsViewModel()
    
    @Published var proximityObserver: ProximityObserver!
    @Published var nearbyContent = [Content]()
    @Published var estimoteCloudCredentials:CloudCredentials!
    @Published var zone:ProximityZone!
    
    private var beaconsService = BeaconsService()
    
    let didChange = PassthroughSubject<Void, Never>()
    
    @Published var beacons = [String](){
        didSet { didChange.send() }
    }
    
    @Published var beaconsModel = [[BeaconsObjectModel]](){
        didSet { didChange.send() }
    }
    
    override init(){
        super.init()
        
        featchBeacons()
    }
    
    func featchBeacons(){
        self.estimoteCloudCredentials = CloudCredentials(appID: "mateuszrozkosz97-gmail-com-72t", appToken: "6a801bf31ca12adff113be06414b9e2d")
        
        self.proximityObserver = ProximityObserver(credentials: estimoteCloudCredentials, onError: { error in
            print("ProximityObserver error: \(error)")
        })
        
        self.zone = ProximityZone(tag: "mateuszrozkosz97-gmail-com-72t", range: ProximityRange(desiredMeanTriggerDistance: 0.5)!)
        
        self.zone.onContextChange = { contexts in
            
            self.beacons = []
            
            for i in contexts {
                self.beacons.append(i.deviceIdentifier)
            }
            
            self.getDataByQuery()
            
        }
        
        self.zone.onExit = { zoneContext in
            
            self.beacons = self.beacons.removingDuplicates()
            
            self.beacons.removeAll { value in
                return value == zoneContext.deviceIdentifier
            }
            print( self.beacons)
            self.getDataByQuery()
            
            self.nearbyContent.removeAll()
        }
        
        proximityObserver.startObserving([self.zone])
    }
    
    public func getDataByQuery() {
        self.beaconsService.getData(beaconsUUIDs: self.beacons){ result in
            DispatchQueue.main.async {
                
                self.beaconsModel =  result.map(BeaconsObjectModel.init).chunked(into: 2)
            }
        }
    }
    
}

extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()
        
        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }
    
    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
    
    func chunked(into size: Int)->[[Element]]{
        return stride(from: 0, to: count, by: size).map{
            Array(self[$0..<Swift.min($0 + size, count)])
        }
    }
}



struct BeaconsObjectModel {
    
    var pleace: PleacesDataModel
    init(pleace: PleacesDataModel){
        self.pleace = pleace
    }
    
    var id: Int {
        return self.pleace.id!
    }
    
    var coverImage: String {
        return self.pleace.coverImage!
    }
    
    var description: String {
        return self.pleace.description!
    }
    
    var name: String {
        return self.pleace.name!
    }
    
    var location: String {
        return self.pleace.location!
    }
}
