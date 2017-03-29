//
//  AirportDetailedViewController.swift
//  Airports
//
//  Created by Zhilnikov, Alexey on 29/3/17.
//  Copyright © 2017 Zhilnikov, Alexey. All rights reserved.
//

import MapKit

class AirportDetailedViewController: UIViewController {
    
    @IBOutlet fileprivate weak var currencyCodeLabel: UILabel!
    @IBOutlet fileprivate weak var timezoneLabel: UILabel!
    @IBOutlet fileprivate weak var map: MKMapView!
    
    var airportDetails: Airport?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyCodeLabel.text = airportDetails?.currencyCode
        timezoneLabel.text = airportDetails?.timezone
        
        if let latitude = airportDetails?.location?.latitude,
            let longitude = airportDetails?.location?.longitude {
            
            let location = CLLocationCoordinate2DMake(latitude, longitude)
            map.setRegion(MKCoordinateRegionMakeWithDistance(location, 10000, 10000), animated: true)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            annotation.title = airportDetails?.code
            
            var subtitle = airportDetails?.displayName ?? ""
            if let countryName = airportDetails?.country?.displayName, !countryName.isEmpty {
                if !subtitle.isEmpty {
                    subtitle += ", "
                }
                subtitle += countryName
            }
            annotation.subtitle = subtitle
            
            map.addAnnotation(annotation)
        }
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
}
