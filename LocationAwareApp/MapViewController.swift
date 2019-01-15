//
//  MapViewController.swift
//  AssignmentApp
//
//  Created by Dawid  on 08/02/2018.
//  Copyright © 2018 Dawid Bazan. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var map: MKMapView!
    
    var manager = CLLocationManager()
    var info = [LocationsStats]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        map.delegate = self
        
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        
        let url = URL(string: "http://radikaldesign.co.uk/sandbox/hygiene.php?op=s_loc&lat=\(locValue.latitude)&long=\(locValue.longitude)")
        
        do{
            let data = try Data(contentsOf: url!)
            info = try JSONDecoder().decode([LocationsStats].self, from: data)
        } catch let error {
            print (error)
        }
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.005, 0.005)
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(locValue.latitude, locValue.longitude)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        map.setRegion(region, animated: true)
        
        for l in info{
        
            let lat = l.Latitude
            let lon = l.Longitude
            let doubleLat = (lat as NSString).doubleValue
            let doubleLon = (lon as NSString).doubleValue

            let annotation = CustomPin()
            annotation.image = UIImage(named:"pin")
            annotation.coordinate = CLLocationCoordinate2DMake(doubleLat, doubleLon)
            annotation.title = l.BusinessName
            annotation.subtitle = l.AddressLine1
            map.addAnnotation(annotation)

        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard !annotation.isKind(of: MKUserLocation.self) else {return nil}
        let annotationIdentifier = "AnnotationIdentifier"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier)
        
        if annotationView == nil{
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            annotationView!.canShowCallout = true
        }
        else{
            annotationView!.annotation = annotation
        }
        
        let customPointAnnotation = annotation as! CustomPin
        annotationView!.image = customPointAnnotation.image
        return annotationView
    }
    
}
