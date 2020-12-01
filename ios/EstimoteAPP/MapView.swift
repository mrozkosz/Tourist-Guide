//
//  MapView.swift
//  EstimoteAPP
//
//  Created by Mateusz on 01/12/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import SwiftUI
import MapKit

struct MapView: View {

    @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 29.049, longitude: -95.269), latitudinalMeters: 500, longitudinalMeters: 500)
    
    var body: some View {
        
        
        if #available(iOS 14.0, *) {
            Map(coordinateRegion: $region)
        } else {
            // Fallback on earlier versions
        }
              
       
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
