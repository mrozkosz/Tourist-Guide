//
//  BeaconDetector.swift
//  EstimoteAPP
//
//  Created by Mateusz on 01/12/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//
import SwiftUI
//import EstimoteProximitySDK
import Combine

struct Content: Identifiable {
    var id: String
    let title: String
    let subtitle: String
}

//class BeaconDetector:NSObject,ObservableObject{
//    
//    static let shared = BeaconDetector()
//    
//    @Published var proximityObserver: ProximityObserver!
//    @Published var nearbyContent = [Content]()
//    @Published var estimoteCloudCredentials:CloudCredentials!
//    @Published var zone:ProximityZone!
//    
//    let didChange = PassthroughSubject<Void, Never>()
//
//    @Published var beacons = [String](){
//        didSet { didChange.send() }
//    }
//    
//   
//    
//    override init(){
//        super.init()
//        
//        featchBeacons()
//    }
//    
//    func featchBeacons(){
//        self.estimoteCloudCredentials = CloudCredentials(appID: "mateuszrozkosz97-gmail-com-72t", appToken: "6a801bf31ca12adff113be06414b9e2d")
//        
//        self.proximityObserver = ProximityObserver(credentials: estimoteCloudCredentials, onError: { error in
//            print("ProximityObserver error: \(error)")
//        })
//        
//        self.zone = ProximityZone(tag: "mateuszrozkosz97-gmail-com-72t", range: ProximityRange(desiredMeanTriggerDistance: 0.5)!)
//        
//        self.zone.onContextChange = { contexts in
//            print(contexts)
//            self.beacons = []
//
//            for i in contexts {
//                self.beacons.append(i.deviceIdentifier)
//            }
//            
//        }
//        
//        self.zone.onExit = { zoneContext in
//            
//            self.beacons = self.beacons.removingDuplicates()
//
//            self.beacons.removeAll { value in
//              return value == zoneContext.deviceIdentifier
//            }
//            
//            self.nearbyContent.removeAll()
//        }
//        
//        proximityObserver.startObserving([self.zone])
//    }
//
//}
//
//extension Array where Element: Hashable {
//    func removingDuplicates() -> [Element] {
//        var addedDict = [Element: Bool]()
//
//        return filter {
//            addedDict.updateValue(true, forKey: $0) == nil
//        }
//    }
//
//    mutating func removeDuplicates() {
//        self = self.removingDuplicates()
//    }
//}


//struct BeaconObjectModel {
//
//    var beacon: ProximityZoneContext
//
//    init(beacon: ProximityZoneContext){
//        self.beacon = beacon
//    }
//
//    var id: String {
//        return self.beacon.deviceIdentifier
//    }
//
//    var tag: String{
//        return self.beacon.tag
//    }
//
//    var name: String{
//        return self.beacon.attachments["mateuszrozkosz97-gmail-com-72t/title"] ?? "nil"
//    }
//}
