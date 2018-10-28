//
//  UserDefaults.swift
//  Weather
//
//  Created by Tales Pinheiro De Andrade on 28/10/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation

extension UserDefaults {

    @objc
    dynamic var cities: [City]? {
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

