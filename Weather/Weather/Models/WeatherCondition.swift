//
//  WeatherCondition.swift
//  Weather
//
//  Created by Tales Pinheiro De Andrade on 27/10/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation

enum WeatherCondition: String, Codable {
    case thunderstorm = "Thunderstorm"
    case drizzle = "Drizzle"
    case rain = "Rain"
    case snow = "Snow"
    case clear = "Clear"
    case clouds = "Clouds"
    case mist = "Mist"
}
