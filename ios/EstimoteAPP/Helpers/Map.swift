//
//  Map.swift
//  EstimoteAPP
//
//  Created by Mateusz on 03/12/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import Foundation
import SwiftUI
import MapKit



struct Map: UIViewRepresentable {
    
    @State var lat:Double
    @State var long:Double
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.showsUserLocation = true
        mapView.showsScale = true
        mapView.userTrackingMode = .follow
        
        
        mapView.delegate = context.coordinator
        
        let annotation = MKPointAnnotation()
        annotation.title = "xxwfewfwewe"
        annotation.subtitle = "Subtitle"
        annotation.coordinate = CLLocationCoordinate2D(latitude: lat , longitude: long)
       
        mapView.addAnnotation(annotation)
        
        return mapView
    }
    
    
    func updateUIView(_ view: MKMapView, context: Context) {
        let span = MKCoordinateSpan(latitudeDelta: 2, longitudeDelta: 2)
        
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lat , longitude: long), span: span)
        
        view.setRegion(region, animated: true)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: Map
        
        init(_ parent: Map) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = .blue
            renderer.lineWidth = 5
            return renderer
        }
    }
}



//struct Map: UIViewRepresentable {
//
//    @State var coordinates: [CLLocationCoordinate2D]
//
//    func makeUIView(context: Context) -> MKMapView {
//        let mapView = MKMapView()
//        mapView.showsUserLocation = true
//        mapView.showsScale = true
//        mapView.userTrackingMode = .follow
//
//
//        mapView.delegate = context.coordinator
//
//        var pleaceMarks = [MKPlacemark]()
//
//
//        for pleaceMark in coordinates {
//            let annotation = MKPointAnnotation()
//            annotation.title = "xxwfewfwewe"
//            annotation.subtitle = "Subtitle"
//            annotation.coordinate = pleaceMark
//
//            mapView.addAnnotation(annotation)
//
//            pleaceMarks.append(MKPlacemark(coordinate: pleaceMark))
//
//        }
//
//        return mapView
//    }
//
//
//    func updateUIView(_ view: MKMapView, context: Context) {
//        let span = MKCoordinateSpan(latitudeDelta: 2, longitudeDelta: 2)
//
////        let region = MKCoordinateRegion(center: coordinates.first ?? CLLocationCoordinate2D(latitude: 50, longitude: 19), span: span)
//
////        view.setRegion(region, animated: true)
//    }
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//    class Coordinator: NSObject, MKMapViewDelegate {
//        var parent: Map
//
//        init(_ parent: Map) {
//            self.parent = parent
//        }
//
//        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
//            let renderer = MKPolylineRenderer(overlay: overlay)
//            renderer.strokeColor = .blue
//            renderer.lineWidth = 5
//            return renderer
//        }
//    }
//}
//
//
