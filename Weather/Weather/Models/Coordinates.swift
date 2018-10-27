//
//  Coordinates.swift
//  Weather
//
//  Created by Tales Pinheiro De Andrade on 20/10/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import CoreLocation

class Coordinates: NSObject, Codable {
    let lon, lat: Double?

    init(lon: Double?, lat: Double?) {
        self.lon = lon
        self.lat = lat
    }

    convenience init(location: CLLocationCoordinate2D) {
        self.init(lon: location.longitude, lat: location.latitude)
    }

}
