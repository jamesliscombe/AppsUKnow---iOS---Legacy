//
//  FindViewController.swift
//  AppsUKnow
//
//  Created by James Liscombe on 09/02/2019.
//  Copyright © 2019 appsuknow. All rights reserved.
//

import UIKit
import MapKit

class FindViewController: UIViewController {
    
    @IBOutlet weak var takeawayLocationMapView: MKMapView!
    let regionRadius: CLLocationDistance = 800
    let latitiude = 55.000219
    let longitude = -1.425143
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let initialLocation = CLLocation(latitude: self.latitiude, longitude: self.longitude)
        centerMapOnLocation(location: initialLocation)
        
        let mapAndInfoModel = MapAndInfoModel(title: "SFC South Shields", locationName: "SFC South Shields - South Shields", discipline: "Food/Takeaway", coordinate: CLLocationCoordinate2D(latitude: latitiude, longitude: longitude))
        takeawayLocationMapView.addAnnotation(mapAndInfoModel)
        takeawayLocationMapView.isUserInteractionEnabled = false
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        takeawayLocationMapView.setRegion(coordinateRegion, animated: true)
    }

}
