//
//  City.swift
//  Weather
//
//  Created by Tales Pinheiro De Andrade on 20/10/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation

class City: NSObject, Codable {
    let id: Int?
    let name: String?
    let coordinates: Coordinates?
    let population: Int?

    init(id: Int? = nil, name: String, coord: Coordinates, population: Int? = nil) {
        self.id = id
        self.name = name
        self.coordinates = coord
        self.population = population
    }

    init(name: String, coordinates: Coordinates) {
        precondition(name.isEmpty == false, "City name cannot be empty")
        self.id = nil
        self.name = name
        self.coordinates = coordinates
        self.population = nil
    }

    enum CodingKeys: String, CodingKey {
        case id, name
        case coordinates = "coord"
        case population
    }
}
