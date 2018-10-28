//
//  MapViewController.swift
//  Weather
//
//  Created by Tales Pinheiro De Andrade on 28/10/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    private let userDefaults = UserDefaults.standard

    fileprivate var cities: [City]? {
        get {
            return self.userDefaults.cities
        }
        set {
            self.userDefaults.cities = newValue
        }
    }

    private lazy var mapView: MKMapView = {
        let view = MKMapView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        return locationManager
    }()

    override func loadView() {
        self.view = self.mapView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if self.cities?.isEmpty != false {
            self.locationManager.requestWhenInUseAuthorization()
            if CLLocationManager.locationServicesEnabled() {
                locationManager.requestLocation()
            }
        }
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(addPin(sender:)))
        self.mapView.addGestureRecognizer(gesture)
        self.mapView.delegate = self

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.addCitiesToMap()
    }

    @objc
    func addPin(sender: UILongPressGestureRecognizer) {
        guard sender.state == .began else {
            return
        }
        let touchLocation = sender.location(in: self.mapView)
        let locationCoordinates = self.mapView.convert(touchLocation, toCoordinateFrom: self.mapView)
        let annotation = MKPointAnnotation()
        annotation.coordinate = locationCoordinates
        let geocoder = CLGeocoder()
        let location = CLLocation(latitude: locationCoordinates.latitude, longitude: locationCoordinates.longitude)

        geocoder.reverseGeocodeLocation(location) { [unowned self] (placemarks, error) in

            guard let placemark = placemarks?.first, let stateName = placemark.administrativeArea else {
                return
            }

            let cityName = placemark.subAdministrativeArea ?? placemark.locality ?? "-"
            annotation.title = cityName
            annotation.subtitle = stateName
            self.mapView.addAnnotation(annotation)

            let coordinates = Coordinates(location: locationCoordinates)
            let city = City(name: cityName, coordinates: coordinates)
            self.cities?.append(city)
        }

    }

    func addCitiesToMap() {
        for city in self.cities ?? [] {
            if let coordinnate = city.coordinates, let lat = coordinnate.lat, let lon = coordinnate.lon {
                let annotation = MKPointAnnotation()
                annotation.coordinate = CLLocationCoordinate2D(latitude: lat,
                                                               longitude: lon)
                annotation.title = city.name ?? "-"
                self.mapView.addAnnotation(annotation)
            }
        }
    }

}

extension MapViewController: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            fatalError()
        }
        let coordinates = Coordinates(location: location.coordinate)
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            guard let placemark = placemarks?.first, let cityName = placemark.administrativeArea else {
                fatalError("FIXME")
            }
            let city = City(name: cityName, coordinates: coordinates)
            self.userDefaults.cities = [city]
        }

    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            manager.requestLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let error = error as? CLError {
            switch error {
            case CLError.locationUnknown:
                print("location unknown")
            case CLError.denied:
                print("denied")
            default:
                print("other Core Location error")
            }
        } else {
            print("other error:", error.localizedDescription)
        }
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let foundCity = self.cities?.first(where: { city in
            return city.coordinates?.lon == view.annotation?.coordinate.longitude &&
                city.coordinates?.lat == view.annotation?.coordinate.latitude
        })
        guard let city = foundCity, let index = self.cities?.firstIndex(of: city)
            else { return }
        fatalError()
    }
}

