//
//  BeaconDetector.swift
//  Estimote
//
//  Created by Mateusz on 30/05/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import SwiftUI
import EstimoteProximitySDK
struct Content: Identifiable {
    var id: String
    let title: String
    let subtitle: String
}

class BeaconDetector:NSObject,ObservableObject{
    @Published var proximityObserver: ProximityObserver!
    @Published var nearbyContent = [Content]()
    @Published var estimoteCloudCredentials:CloudCredentials!
    @Published var zone:ProximityZone!
    override init(){
        super.init()
        self.estimoteCloudCredentials = CloudCredentials(appID: "mateuszrozkosz97-gmail-com-72t", appToken: "6a801bf31ca12adff113be06414b9e2d")
        
        self.proximityObserver = ProximityObserver(credentials: estimoteCloudCredentials, onError: { error in
            print("ProximityObserver error: \(error)")
        })
        
        self.zone = ProximityZone(tag: "mateuszrozkosz97-gmail-com-72t", range: ProximityRange(desiredMeanTriggerDistance: 0.5)!)
        
        self.zone.onContextChange = { contexts in
         
            for i in contexts {
                print("xxxxxx - ",i.deviceIdentifier)
                let id = i.deviceIdentifier
                let title = i.attachments["mateuszrozkosz97-gmail-com-72t/title"]
                self.nearbyContent.append(Content(id: id, title:title ?? "null", subtitle: id))
            }
        }
        
        self.zone.onExit = { zoneContext in
            print("Exited \(zoneContext.deviceIdentifier)")
            self.nearbyContent.removeAll()
        }
        proximityObserver.startObserving([self.zone])
    }
}
