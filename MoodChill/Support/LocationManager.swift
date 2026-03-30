//
//  LocationManager.swift
//  MoodChill
//
//  Created by Dimitris Poluzos on 30/3/26.
//

import Foundation
import Combine
import CoreLocation

final class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    private let manager = CLLocationManager()
    private let geocoder = CLGeocoder()
    
    @Published var latitude: Double?
    @Published var longitude: Double?
    @Published var cityName: String = "Your Location"
    @Published var authorizationDenied = false
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyKilometer
    }
    
    func requestLocation() {
        let status = manager.authorizationStatus
        
        switch status {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse, .authorizedAlways:
            manager.requestLocation()
        case .denied, .restricted:
            authorizationDenied = true
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = manager.authorizationStatus
        
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            manager.requestLocation()
        case .denied, .restricted:
            authorizationDenied = true
        case .notDetermined:
            break
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        
        latitude = location.coordinate.latitude
        longitude = location.coordinate.longitude
        
        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
            guard let self else { return }
            
            if let placemark = placemarks?.first {
                let city = placemark.locality ?? placemark.administrativeArea ?? "Your location"
                let country = placemark.country ?? ""
                
                if country.isEmpty {
                    self.cityName = city
                } else {
                    self.cityName = "\(city), \(country)"
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("LOCATION ERROR:", error)
    }
}
