//
//  ForecastItem.swift
//  Weather
//
//  Created by Tales Pinheiro De Andrade on 20/10/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation

class ForecastItem: Codable {
    let base: String?
    let id: Int?
    let name: String?
    let dt: Int
    let coordinates: Coordinates?
    let weatherDetails: WeatherDetails
    let weather: [Weather]
    let clouds: Clouds
    let wind: Wind
    let rain: Rain?
    let snow: Snow?
    let sys: Sys
    let dtTxt: String?

    init(dt: Int,
         main: WeatherDetails,
         weather: [Weather],
         clouds: Clouds,
         wind: Wind,
         rain: Rain?,
         snow: Snow?,
         sys: Sys,
         dtTxt: String,
         base: String? = nil,
         id: Int? = nil,
         name: String? = nil,
         coordinates: Coordinates? = nil) {
        self.base = base
        self.id = id
        self.name = name
        self.dt = dt
        self.weatherDetails = main
        self.weather = weather
        self.clouds = clouds
        self.wind = wind
        self.rain = rain
        self.snow = snow
        self.sys = sys
        self.dtTxt = dtTxt
        self.coordinates = coordinates
    }

    enum CodingKeys: String, CodingKey {
        case coordinates = "coord"
        case weather, base, wind, rain, snow, clouds, dt, sys, id, name
        case dtTxt = "dt_txt"
        case weatherDetails = "main"
    }

}
