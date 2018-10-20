//
//  City.swift
//  Weather
//
//  Created by Tales Pinheiro De Andrade on 20/10/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation

class City: NSObject, Codable {
    let name: String
    let coordinates: Coordinates

    init(name: String, coordinates: Coordinates) {
        precondition(name.isEmpty == false, "City name cannot be empty")
        self.name = name
        self.coordinates = coordinates
    }
}
