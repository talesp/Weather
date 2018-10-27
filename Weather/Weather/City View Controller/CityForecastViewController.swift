//
//  CityForecastViewController.swift
//  Weather
//
//  Created by Tales Pinheiro De Andrade on 21/10/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import UIKit

class CityForecastViewController: UIViewController {

    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var weatherConditionLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    
    var city: City?

    private let webservice = Webservice()

    var todayWeather: ForecastItem? {
        didSet {
            DispatchQueue.main.async { [unowned self] in
                if let todayWeather = self.todayWeather {
                    self.weatherConditionLabel.text = todayWeather.weather.first?.description.rawValue ?? ""
                    self.temperatureLabel.text = "\(todayWeather.weatherDetails.temperature) \(UserDefaults.standard.temperatureUnit)"
                }
                else {
                    self.weatherConditionLabel.text = "--"
                    self.temperatureLabel.text = "--"
                }

            }
        }
    }

    fileprivate var dataSource = [[ForecastItem]]()

    var forecast: Forecast? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let forecast = self?.forecast else {
                    self?.tableView.isHidden = true
                    return
                }
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyyMMdd"
                let dictionary = Dictionary(grouping: forecast.list, by: { element -> String in
                    let date = Date(timeIntervalSince1970: TimeInterval(element.dt))
                    return formatter.string(from: date)
                })
                let sorted = dictionary.keys.sorted()
                sorted.forEach({ key in
                    if let value = dictionary[key] {
                        self?.dataSource.append(value)
                    }
                })
                self?.tableView.isHidden = false
                self?.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.allowsSelection = false
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.isHidden = true
        self.cityNameLabel.text = city?.name ?? ""
        self.navigationController?.setNavigationBarHidden(false, animated: true)

        let locale = Locale.current
        guard let coordinates = self.city?.coordinates else {
            return
        }
        let weatherResource = ForecastItem.resource(for: coordinates,
                                                    units: SystemOfUnits(usesMetricSystem: locale.usesMetricSystem))

        _ = self.webservice.load(weatherResource) { result in
            switch result {
            case .success(let value):
                self.todayWeather = value
            case .failure(let error):
                dump(error)
                fatalError()
            }
        }

        let forecastResource = Forecast.resource(for: coordinates,
                                                 units: SystemOfUnits(usesMetricSystem: locale.usesMetricSystem))
        _ = self.webservice.load(forecastResource) { result in
            switch result {
            case .success(let value):
                self.forecast = value
            case .failure(let error):
                dump(error)
                fatalError()
            }
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

}

extension CityForecastViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataSource.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let firstItemOfSection = self.dataSource[section].first else { return "-" }
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("ddMMYYYY")
        let dateString = formatter.string(from: Date(timeIntervalSince1970: TimeInterval(firstItemOfSection.dt)))
        return "Forecast for: \(dateString)"
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastItem") as? TableViewCell else {
            return UITableViewCell()
        }
        cell.setup(model: self.dataSource[indexPath.section][indexPath.row])
        return cell
    }

}
