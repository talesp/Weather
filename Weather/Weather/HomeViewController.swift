//
//  ViewController.swift
//  Weather
//
//  Created by Tales Pinheiro De Andrade on 19/10/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

extension UserDefaults {
    @objc dynamic var cities: [City]? {
        get {
            guard let data = object(forKey: "cities") as? Data else {
                return nil
            }
            let decoder = JSONDecoder()
            do {
                return try decoder.decode([City].self, from: data)
            }
            catch {
                fatalError("\(error)")
            }
        }
        set {
            do {
                let encoder = JSONEncoder()
                let data = try encoder.encode(newValue)
                willChangeValue(for: \.cities)
                set(data, forKey: "cities")
                didChangeValue(for: \.cities)
            }
            catch {
                fatalError("\(error)")
            }
        }
    }
}

class HomeViewController: UIViewController {

    @IBOutlet var mapView: MKMapView!
    @IBOutlet var tableView: UITableView!
    private let webservice = Webservice()
    private let userDefaults = UserDefaults()
    var observer: NSKeyValueObservation?
    var cities: [City]?

    private lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        return locationManager
    }()

    deinit {
        observer?.invalidate()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        if let cities = self.userDefaults.cities, cities.isEmpty == false {
             self.cities = cities
        }
        else {
            self.locationManager.requestWhenInUseAuthorization()
            if CLLocationManager.locationServicesEnabled() {
                locationManager.requestLocation()
            }
        }
        observer = self.userDefaults.observe(\.cities, options: [.initial, .old, .new]) { (defaults, change) in
            dump(change)
            if let cities = change.newValue {
                self.cities = cities
                self.tableView.reloadData()
            }
        }

        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.delegate = self
        self.tableView.dataSource = self

        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(addPin(sender:)))
        gesture.minimumPressDuration = 0.5
        self.mapView.addGestureRecognizer(gesture)
    }

    @objc
    func addPin(sender: UILongPressGestureRecognizer) {
        let touchLocation = sender.location(in: self.mapView)
        let locationCoordinates = self.mapView.convert(touchLocation, toCoordinateFrom: self.mapView)
        let annotation = MKPointAnnotation()
        annotation.coordinate = locationCoordinates
        let geocoder = CLGeocoder()
        let location = CLLocation(latitude: locationCoordinates.latitude, longitude: locationCoordinates.longitude)
        geocoder.reverseGeocodeLocation(location) { [unowned self] (placemarks, error) in
            guard let placemark = placemarks?.first, let stateName = placemark.administrativeArea else {
                fatalError("FIXME")
            }
            let cityName = placemark.subAdministrativeArea ?? placemark.locality ?? "-"
            annotation.title = cityName
            annotation.subtitle = stateName
            self.mapView.addAnnotation(annotation)

            let coordinates = Coordinates(location: locationCoordinates)
            let city = City(name: cityName, coordinates: coordinates)
            self.cities?.append(city)
            self.userDefaults.cities = self.cities
        }
        
    }
}

extension HomeViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            fatalError("fuem")
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

//        let locale = Locale.current
//
//        let resource = ForecastCity.resource(for: coordinates,
//                                             units: SystemOfUnits(usesMetricSystem: locale.usesMetricSystem))
//
//        _ = self.webservice.load(resource) { result in
//            switch result {
//            case .success(let value):
//                #warning("TODO")
//            case .failure(let error):
//                #warning("TODO")
//            }
//        }
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        #warning("TODO")
        print(error)
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cities?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        guard let city = self.cities?[indexPath.row] else {
            fatalError("wrong cell")
        }
        cell?.textLabel?.text = city.name
        return cell!
    }
}
