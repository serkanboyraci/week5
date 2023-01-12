//
//  MapViewController.swift
//  week5
//
//  Created by Ali serkan Boyracı  on 12.01.2023.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    private let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    private func setup() {
        mapView.delegate = self // to learn user location navigate
        locationManager.requestWhenInUseAuthorization() // to take permit location
        mapView.showsUserLocation = true // we can see as blue dot.
        
        if CLLocationManager.locationServicesEnabled() { //if it is closed, nothing will done
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest //like enumarations but it is constant
            locationManager.startUpdatingLocation() // to update location
        }
        
        let coordinates: [CLLocationCoordinate2D] = [
            .init(latitude: 39.99059, longitude: 32.65352),
            .init(latitude: 39.98957, longitude: 32.65092),
            .init(latitude: 39.99016, longitude: 32.65253)
        ]
        
        let polyline = MKPolyline(coordinates: coordinates, count: coordinates.count)
        mapView.addOverlay(polyline)
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let locValue: CLLocationCoordinate2D = manager.location?.coordinate {
            
  //          mapView.mapType = .standard // we take only standar map layout
            
            let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005) // more little more detail
            let region = MKCoordinateRegion(center: locValue, span: span) // center is user location
            
            mapView.setRegion(region, animated: true)
            
  //          let annotation = MKPointAnnotation()
   //         annotation.coordinate = locValue
  //          annotation.title = "ME"
  
  //          mapView.removeAnnotations(mapView.annotations) // if we dont do this every opdate locations, system put one annotation and we can see lots of annotations.
   //         mapView.addAnnotation(annotation)
            
        }
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polyLine = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: polyLine) // line 
            renderer.strokeColor = .systemBlue
            renderer.lineWidth = 3
            return renderer
        }
        return MKOverlayRenderer()
    }
}


