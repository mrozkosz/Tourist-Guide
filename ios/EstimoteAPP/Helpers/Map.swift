//
//  Map.swift
//  EstimoteAPP
//
//  Created by Mateusz on 03/12/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import SwiftUI
import MapKit
import CoreLocation
import AVFoundation

struct Map: UIViewRepresentable{
    var locationManager = CLLocationManager()
    @Binding var destination: CLLocationCoordinate2D
    @Binding var startedNavigation:Bool
    
    func setLocationManager() {
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            handleAuthStatus(locationManager: locationManager, status: CLLocationManager.authorizationStatus())
        }else{
            print("Location Services Disabled")
        }
    }
    
    func handleAuthStatus(locationManager:CLLocationManager, status:CLAuthorizationStatus){
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted, .denied:
            break
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.requestAlwaysAuthorization()
            locationManager.requestWhenInUseAuthorization()
            break
        @unknown default:
            break
        }
        guard let location = locationManager.location?.coordinate else { return }
        print(location)
    }
    
    func centerToUser(location:CLLocationCoordinate2D, view:MKMapView){
        let region = MKCoordinateRegion(center: location, latitudinalMeters: 200, longitudinalMeters: 200)
        view.setRegion(region, animated: true)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.showsUserLocation = true
        mapView.showsScale = true
        mapView.userTrackingMode = .follow
        
        mapView.delegate = context.coordinator
        
        setLocationManager()
        locationManager.delegate = context.coordinator
        locationManager.startUpdatingLocation()
        
        
        return mapView
    }
    
    
    func updateUIView(_ view: MKMapView, context: Context) {
        
        
        guard let location = locationManager.location?.coordinate else { return }
        
        let sourcePlacemark =  MKPlacemark(coordinate: location)
        let destinationPlacemark =  MKPlacemark(coordinate: destination)
        
        let sourceItem = MKMapItem(placemark: sourcePlacemark)
        let destinationItem = MKMapItem(placemark: destinationPlacemark)
        
        let routeRequest = MKDirections.Request()
        
        routeRequest.source = sourceItem
        routeRequest.destination = destinationItem
        routeRequest.transportType = .automobile
        
        let directions = MKDirections(request: routeRequest)
        directions.calculate{ (response, err) in
            if let err = err{
                print(err.localizedDescription)
                return
            }
            
            guard let response = response, let routes = response.routes.first else {return}
            view.removeOverlays(view.overlays)
            view.addOverlay(routes.polyline)
            
            if startedNavigation {
                //print("text")
                if let location = locationManager.location {
                    
                    let userPosition = location.coordinate
                    centerToUser(location: userPosition, view:view)
                }
            }else{
                view.setVisibleMapRect(routes.polyline.boundingMapRect,edgePadding: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16), animated: true)
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    
    class Coordinator: NSObject, MKMapViewDelegate, CLLocationManagerDelegate {
        var parent: Map
        
        init(_ parent: Map) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = .magenta
            renderer.lineWidth = 5
            return renderer
        }
    }
}






