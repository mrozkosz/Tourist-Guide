//
//  LocationMonitoring.swift
//  EstimoteAPP
//
//  Created by Mateusz on 05/01/2021.
//  Copyright © 2021 Mateusz. All rights reserved.
//

import Foundation

import CoreLocation
class LocationMonitoring:ObservableObject{
    
    var isEnabled:Bool = false
    
    init(){
        checkStatus()
    }
    
    func checkStatus(){
        
        switch(CLLocationManager.authorizationStatus()) {
        case .restricted:
            isEnabled = false
        case .denied:
            isEnabled = false
        @unknown default:
            isEnabled = true
        }
    }
    
}
