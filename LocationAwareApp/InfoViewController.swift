//
//  InfoViewController.swift
//  AssignmentApp
//
//  Created by Dawid  on 23/01/2018.
//  Copyright © 2018 Dawid Bazan. All rights reserved.
//

import UIKit
import MapKit

class InfoViewController: UIViewController {
    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var address1: UILabel!
    @IBOutlet weak var address2: UILabel!
    @IBOutlet weak var address3: UILabel!
    @IBOutlet weak var postcode: UILabel!
    @IBOutlet weak var rating: UILabel!
    
    var info:LocationsStats?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let lat = info?.Latitude
        let lon = info?.Longitude
        let doubleLat = (lat! as NSString).doubleValue
        let doubleLon = (lon! as NSString).doubleValue
        print(doubleLat, doubleLon)
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.001, 0.001)
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(doubleLat, doubleLon)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        map.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = location
        annotation.title = info?.BusinessName
        map.addAnnotation(annotation)
        
        nameLbl.text = info?.BusinessName
        address1.text = info?.AddressLine1
        address2.text = info?.AddressLine2
        address3.text = info?.AddressLine3
        postcode.text = info?.PostCode
        
    }

}
