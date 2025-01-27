//
//  LocationUseCase.swift
//  TestCode
//
//  Created by Adrian Prieto Villena on 17/1/25.
//

import CoreLocation

enum TypeRequestLocation {
    case always
    case whenInUse
}

class LocationManager: NSObject, CLLocationManagerDelegate, LocationManagerProtocol {
    private let manager = CLLocationManager()
    private let typeRequestLocation: TypeRequestLocation
    
    init(typeRequestLocation: TypeRequestLocation = .always,
         accuracy: CLLocationAccuracy = kCLLocationAccuracyBest) {
        self.typeRequestLocation = typeRequestLocation
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = accuracy
    }

    func getLocation() -> Coordinate? {
        let locationStatus = permissionsStatus()
        if locationStatus == .authorized {
            guard let latitude = manager.location?.coordinate.latitude,
                  let longitude = manager.location?.coordinate.longitude else {
                return nil
            }
            return Coordinate(lat: latitude , lng: longitude)
        } else {
            return nil
        }
    }

    func hasPermissions() async -> Bool {
        switch permissionsStatus() {
        case .authorized:
            return true
        case .notDetermined:
            let status =  requestPermission()
            return status == .authorizedAlways || status == .authorizedWhenInUse
        default:
            return false
        }
    }

    func permissionsStatus() -> CustomPermissions {
        switch manager.authorizationStatus {
        case .notDetermined:
            return .notDetermined
        case .restricted:
            return .restricted
        case .denied:
            return .denied
        case .authorizedAlways, .authorizedWhenInUse, .authorized:
            return .authorized
        default:
            return .denied
        }
    }
}

private extension LocationManager {
    func requestPermission() -> CLAuthorizationStatus {
        if permissionsStatus() == .notDetermined {
            switch typeRequestLocation {
            case .always:
                manager.requestAlwaysAuthorization()
            case .whenInUse:
                manager.requestWhenInUseAuthorization()
            }
        }
        return manager.authorizationStatus
    }
}
