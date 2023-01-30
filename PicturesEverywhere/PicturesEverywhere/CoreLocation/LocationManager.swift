//
//  LocationManager.swift
//  PicturesEverywhere
//
//  Created by Ezequiel Rasgido on 27/01/2023.
//

import Foundation
import CoreLocation

// MARK: - LocationManager Section

class LocationManager: NSObject {
    
    private let locationManager = CLLocationManager()
    internal var authorizationStatus: CLAuthorizationStatus? {
        return self.locationManager.authorizationStatus
    }
    internal var exposedLocation: CLLocation? {
        return self.locationManager.location
    }
    
    override init() {
        super.init()
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    internal func requestAuthorization() {
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    func getPlace(
        for location: CLLocation,
        completion: @escaping (CLPlacemark?) -> Void
    ) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            guard error == nil else {
                print("*** Error in \(#function): \(error!.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let placemark = placemarks?[0] else {
                print("*** Error in \(#function): placemark is nil")
                completion(nil)
                return
            }
            
            completion(placemark)
        }
    }
}
