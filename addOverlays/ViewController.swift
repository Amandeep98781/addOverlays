//
//  ViewController.swift
//  addOverlays
//
//  Created by Amandeep Kaur on 24/01/21.
//

import UIKit
import MapKit
class ViewController: UIViewController , CLLocationManagerDelegate{

    @IBOutlet weak var map: MKMapView!
  
    var locationManager = CLLocationManager()
   
    let places = Place.getPlaces()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
       locationManager.delegate = self
       locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        let latitude: CLLocationDegrees = 43.64
        let longitude: CLLocationDegrees = -79.38
        
       map.delegate = self
        
       addAnnotationForPlaces()
        
        // Do any additional setup after loading the view.
   addPolyline()
    }
   
    func addAnnotationForPlaces(){
        map.addAnnotations(places)
        let overlays = places.map {MKCircle(center: $0.coordinate, radius: 2000)}
        map.addOverlays(overlays)
    }
    
    
    func addPolyline() {
    let coordinates = places.map {$0.coordinate}
    let polyline = MKPolyline(coordinates: coordinates, count: coordinates.count)
    map.addOverlay(polyline)
}

}
extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKCircle {
            let renderer = MKCircleRenderer(overlay: overlay)
            renderer.fillColor = UIColor.black.withAlphaComponent(0.5)
            renderer.strokeColor = UIColor.green
            renderer.lineWidth = 3
            return renderer
            
        }
        return MKOverlayRenderer()
        
    }
    
    
    
    
    
}
