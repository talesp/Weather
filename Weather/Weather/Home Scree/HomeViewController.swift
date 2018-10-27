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

    var temperatureUnit: String {
        get {
            return ((object(forKey: "TemperatureUnit") as? String) ?? (Locale.current.usesMetricSystem ? "º C" : "f"))
        }
        set {
            set(newValue, forKey: "TemperatureUnit")
        }
    }
}

class HomeViewController: UIViewController {

    @IBOutlet var mapView: MKMapView!
    @IBOutlet var tableView: UITableView!
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
            self.cities = []
            self.locationManager.requestWhenInUseAuthorization()
            if CLLocationManager.locationServicesEnabled() {
                locationManager.requestLocation()
            }
        }
        observer = self.userDefaults.observe(\.cities, options: [.initial, .old, .new]) { (defaults, change) in
//            dump(change)
            if let cities = change.newValue {
                self.cities = cities
                self.tableView.reloadData()
            }
        }

        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.delegate = self
        self.tableView.dataSource = self

        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(addPin(sender:)))
        self.mapView.addGestureRecognizer(gesture)
        self.mapView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.addCitiesToMap()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
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
            self.tableView.reloadData()
            self.userDefaults.cities = self.cities
        }
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? CityForecastViewController else {
            return
        }
        guard let indexPath = tableView.indexPathForSelectedRow else {
            return
        }
        guard let city = self.cities?[indexPath.row] else {
            return
        }

        destination.city = city
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

    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "CityDetail", sender: self)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Deleted")

            self.cities?.remove(at: indexPath.row)
            self.userDefaults.cities = self.cities
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            let annotations = self.mapView.annotations
            self.mapView.removeAnnotations(annotations)
            self.addCitiesToMap()
        }
    }
}

extension HomeViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let foundCity = self.cities?.first(where: { city in
            return city.coordinates?.lon == view.annotation?.coordinate.longitude &&
                city.coordinates?.lat == view.annotation?.coordinate.latitude
        })
        guard let city = foundCity, let index = self.cities?.firstIndex(of: city)
            else { return }
        self.tableView.selectRow(at: IndexPath(row: index, section: 0), animated: false, scrollPosition: .middle)
        self.performSegue(withIdentifier: "CityDetail", sender: self)
    }
}
