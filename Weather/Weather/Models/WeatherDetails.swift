//
//  WeatherDetails.swift
//  Weather
//
//  Created by Tales Pinheiro De Andrade on 27/10/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation

class WeatherDetails: Codable {
    let temperature, pressure: Double
    let humidity: Int
    let temperatureMin, temperatureMax: Double
    let seaLevel, groundLevel: Double?
    let tempKf: Float?


    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case pressure, humidity
        case temperatureMin = "temp_min"
        case temperatureMax = "temp_max"
        case seaLevel = "sea_level"
        case groundLevel = "grnd_level"
        case tempKf = "temp_kf"
    }

    init(temperature: Double,
         pressure: Double,
         humidity: Int,
         temperatureMin: Double,
         temperatureMax: Double,
         seaLevel: Double,
         groundLevel: Double,
         tempKf: Float? = nil) {
        self.temperature = temperature
        self.pressure = pressure
        self.humidity = humidity
        self.temperatureMin = temperatureMin
        self.temperatureMax = temperatureMax
        self.seaLevel = seaLevel
        self.groundLevel = groundLevel
        self.tempKf = tempKf
    }
}
