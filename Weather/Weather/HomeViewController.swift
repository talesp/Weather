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

class HomeViewController: UIViewController {

    @IBOutlet var mapView: MKMapView!
    @IBOutlet var tableView: UITableView!
    private let locationManager = CLLocationManager()
    private let webservice = Webservice()

    private lazy var dataSourceDelegate: HomeViewControllerDataSourceDelegate = {
        return HomeViewControllerDataSourceDelegate()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
        }
    }

}

extension HomeViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            fatalError("fuem")
        }
        let coordinates = Coordinates(location: location.coordinate)
        let locale = Locale.current

        let resource = ForecastCity.resource(for: coordinates,
                                             units: SystemOfUnits(usesMetricSystem: locale.usesMetricSystem))
        
        _ = self.webservice.load(resource) { result in
            switch result {
            case .success(let value):
                #warning("TODO")
            case .failure(let error):
                #warning("TODO")
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        #warning("TODO")
    }
}

class HomeViewControllerDataSourceDelegate: NSObject, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

}
