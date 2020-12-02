//
//  MapView.swift
//  EstimoteAPP
//
//  Created by Mateusz on 01/12/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import SwiftUI
import CoreLocation
import MapKit


struct MapView: View {

   
    var body: some View {
        if #available(iOS 14.0, *) {
           
        } else {
            // Fallback on earlier versions
        }
    }
}

#if DEBUG
struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
#endif
