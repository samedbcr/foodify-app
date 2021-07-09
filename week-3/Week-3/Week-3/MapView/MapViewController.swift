//
//  MapViewController.swift
//  Week-3
//
//  Created by Samed Biçer on 9.07.2021.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addressLabel: UILabel!

    let locationManager = CLLocationManager()
    var lastLocation: CLLocation?

    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
        mapView.delegate = self
    }

    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            //TODO: Kullanıcıya ayarlardan konum servisini açması istenebilir
        }
    }

    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            trackingLocation()
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            break
        case .denied:
            break
        case .authorizedAlways:
            break
        }
    }

    func trackingLocation() {
        mapView.showsUserLocation = true
        showUserLocationCenterMap()
        locationManager.startUpdatingLocation()
        lastLocation = getCenterLocation(mapView: mapView)
        if let lastLocation = lastLocation {
            reverseGeocode(from: lastLocation)
        }
    }

    func showUserLocationCenterMap() {
        print(locationManager.location?.coordinate)
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: 100, longitudinalMeters: 100)
            mapView.setRegion(region, animated: true)
        }
    }

    func getCenterLocation(mapView: MKMapView) -> CLLocation {
        let latitude = mapView.centerCoordinate.latitude
        let longitude = mapView.centerCoordinate.longitude

        return CLLocation(latitude: latitude, longitude: longitude)
    }

    func reverseGeocode(from location: CLLocation) {
        let geoCoder = CLGeocoder()

        geoCoder.reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
            guard let self = self else { return }

            if let error = error {
                print(error)
                return
            }

            guard let placemark = placemarks?.first else { return }
            self.populateAddressLabel(placemark: placemark)
        }
    }

    func populateAddressLabel(placemark: CLPlacemark) {
        let thoroughfare = placemark.thoroughfare ?? ""
        let subThoroughfare = placemark.subThoroughfare ?? ""
        let postalCode = placemark.postalCode ?? ""
        let subLocality = placemark.subLocality ?? ""
        let locality = placemark.locality ?? ""
        let administrativeArea = placemark.administrativeArea ?? ""
        let country = placemark.country ?? ""

        addressLabel.text = "\(thoroughfare) \(subThoroughfare), \(postalCode), \(subLocality), \(locality), \(administrativeArea), \(country)"
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 100, longitudinalMeters: 100)
        mapView.setRegion(region, animated: true)
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let center = getCenterLocation(mapView: mapView)

        guard let lastLocation = lastLocation else { return }
        guard center.distance(from: lastLocation) > 30 else { return }
        self.lastLocation = center

        reverseGeocode(from: center)
    }
}
