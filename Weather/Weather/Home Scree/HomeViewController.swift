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

    fileprivate lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    fileprivate lazy var mapViewController: MapViewController = {
        let viewController = MapViewController()
        return viewController
    }()

    fileprivate var mapView: MKMapView {
        return self.mapViewController.view as! MKMapView
    }

    private lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            self.mapView, self.tableView
            ])
        view.axis = UIScreen.main.traitCollection.verticalSizeClass == .regular ? .vertical : .horizontal
        return view
    }()

    private var verticalConstraint: NSLayoutConstraint?
    private var horizontalConstraint: NSLayoutConstraint?

    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        if newCollection.verticalSizeClass != self.view.traitCollection.verticalSizeClass {
            coordinator.animate(alongsideTransition: { context in
                self.stackView.axis = self.view.traitCollection.verticalSizeClass == .regular ? .vertical : .horizontal

                if newCollection.verticalSizeClass == .regular {
                    self.verticalConstraint?.isActive = true
                }
                else {
                    self.verticalConstraint?.isActive = false
                }
                self.horizontalConstraint?.isActive = self.verticalConstraint?.isActive != true
            })
        }
    }

    private let userDefaults = UserDefaults.standard

    var observer: NSKeyValueObservation?
    var cities: [City]?

    deinit {
        observer?.invalidate()
    }

    override func loadView() {
        self.view = self.stackView
        setupViewConfiguration()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.addChild(self.mapViewController)
        self.didMove(toParent: self)
        
        if let cities = self.userDefaults.cities, cities.isEmpty == false {
             self.cities = cities
        }
        else {
            self.cities = []
        }
        observer = self.userDefaults.observe(\.cities, options: [.initial, .old, .new]) { (defaults, change) in
            if let cities = defaults.cities {
                self.cities = cities
                self.tableView.reloadData()
            }
        }

        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.delegate = self
        self.tableView.dataSource = self

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
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
        }
    }
}

extension HomeViewController: ViewConfiguration {
    func buildViewHierarchy() {

    }

    func setupConstraints() {
        self.verticalConstraint = self.mapView.heightAnchor.constraint(equalTo: self.tableView.heightAnchor)
        self.horizontalConstraint = self.mapView.widthAnchor.constraint(equalTo: self.tableView.widthAnchor)
        if UIScreen.main.traitCollection.verticalSizeClass == .regular {
            self.verticalConstraint?.isActive = true
        }
        else {
            self.verticalConstraint?.isActive = false
        }
        self.horizontalConstraint?.isActive = self.verticalConstraint?.isActive != true
    }

    
}
