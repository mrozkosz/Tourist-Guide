//
//  MapView.swift
//  EstimoteAPP
//
//  Created by Mateusz on 18/12/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import SwiftUI
import CoreLocation
import Combine

struct MapView: View {
    @State var showingDetail = false
    @State var startedNavigation = false
    @State var destinationLat = 0.0
    @State var destinationLong = 0.0
    @ObservedObject var locationManager = LocationManager()
    
    var body: some View {
        ZStack{
            Map(destination: .constant(CLLocationCoordinate2D(latitude: destinationLat, longitude: destinationLong)), startedNavigation: .constant(startedNavigation))
       
            VStack{
                Spacer()
                HStack{
                
                    Spacer()
                    if(!destinationLong.isZero){
                    Text(startedNavigation==true ? "Stop":"Start")
                        .fontWeight(.bold)
                        .font(.headline)
                        .padding(10)
                        .background(startedNavigation==true ? Color.red:Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(25)
                        .offset(x:-60)
                        .onTapGesture {
                            self.startedNavigation.toggle()
                        }
                    }
                    Image("more")
                        .resizable()
                        .scaledToFill()
                        .frame(width:55, height: 55)
                        .padding()
                        .onTapGesture {
                            self.showingDetail.toggle()
                        }.sheet(isPresented: $showingDetail) {
                            ListOfPleaces(showingDetail: $showingDetail, destinationLat: $destinationLat, destinationLong: $destinationLong)
                        }
                }
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}

struct ListOfPleaces: View {
    @Binding var showingDetail:Bool
    @Binding var destinationLat:Double
    @Binding var destinationLong:Double
    @ObservedObject var mapVM = MapViewModel()
    
    var body: some View {
        List(mapVM.mapDataModels, id:\.id){ item in
            Text("\(item.name), \(item.location)").onTapGesture {
                setCoordinates(lat: item.lat, long: item.long)
            }
        }
    }
    func setCoordinates(lat:Double, long:Double){
        destinationLat = lat
        destinationLong = long
        showingDetail = false
    }
}


class LocationManager: NSObject, ObservableObject {

    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }

    @Published var lastLocation: CLLocationCoordinate2D? {
        willSet {
            objectWillChange.send()
        }
    }

    let objectWillChange = PassthroughSubject<Void, Never>()

    private let locationManager = CLLocationManager()
}

extension LocationManager: CLLocationManagerDelegate {

  
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.lastLocation = location.coordinate
        print(#function, location)
    }

}

