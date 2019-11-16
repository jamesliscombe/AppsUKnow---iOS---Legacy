//
//  MapAndInfoModel.swift
//  AppsUKnow
//
//  Created by James Liscombe on 09/02/2019.
//  Copyright © 2019 appsuknow. All rights reserved.
//

import MapKit

class MapAndInfoModel: NSObject, MKAnnotation {
    let title: String?
    let locationName: String
    let discipline: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
}
