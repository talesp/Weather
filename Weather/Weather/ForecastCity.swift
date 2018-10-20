//
//  ForecastCity.swift
//  Weather
//
//  Created by Tales Pinheiro De Andrade on 20/10/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation

class ForecastCity: Codable {
    let coordinates: Coordinates
    let weather: [Weather]
    let base: String
    let main: Main
    let wind: Wind
    let rain: Rain?
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let id: Int
    let name: String

    init(coordinates: Coordinates,
         weather: [Weather],
         base: String,
         main: Main,
         wind: Wind,
         rain: Rain,
         clouds: Clouds,
         dt: Int,
         sys: Sys,
         id: Int,
         name: String) {
        self.coordinates = coordinates
        self.weather = weather
        self.base = base
        self.main = main
        self.wind = wind
        self.rain = rain
        self.clouds = clouds
        self.dt = dt
        self.sys = sys
        self.id = id
        self.name = name
    }

    enum CodingKeys: String, CodingKey {
        case coordinates = "coord"
        case weather, base, main, wind, rain, clouds, dt, sys, id, name
    }
}

class Clouds: Codable {
    let cloudiness: Int

    enum CodingKeys: String, CodingKey {
        case cloudiness = "all"
    }

    init(cloudiness: Int) {
        self.cloudiness = cloudiness
    }
}

class Coordinates: Codable {
    let lon, lat: Double

    init(lon: Double, lat: Double) {
        self.lon = lon
        self.lat = lat
    }
}

class Main: Codable {
    let temperature, pressure: Double
    let humidity: Int
    let temperatureMin, temperatureMax: Double
    let seaLevel, groundLevel: Double?

    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case pressure, humidity
        case temperatureMin = "temp_min"
        case temperatureMax = "temp_max"
        case seaLevel = "sea_level"
        case groundLevel = "grnd_level"
    }

    init(temperature: Double,
         pressure: Double,
         humidity: Int,
         temperatureMin: Double,
         temperatureMax: Double,
         seaLevel: Double,
         groundLevel: Double) {
        self.temperature = temperature
        self.pressure = pressure
        self.humidity = humidity
        self.temperatureMin = temperatureMin
        self.temperatureMax = temperatureMax
        self.seaLevel = seaLevel
        self.groundLevel = groundLevel
    }
}

class Rain: Codable {
    let threeHoursVolume: Double

    enum CodingKeys: String, CodingKey {
        case threeHoursVolume = "3h"
    }

    init(threeHoursVolume: Double) {
        self.threeHoursVolume = threeHoursVolume
    }
}

class Sys: Codable {
    let message: Double
    let sunrise, sunset: Int

    init(message: Double, sunrise: Int, sunset: Int) {
        self.message = message
        self.sunrise = sunrise
        self.sunset = sunset
    }
}

class Weather: Codable {
    let id: Int
    let main, description, icon: String

    init(id: Int, main: String, description: String, icon: String) {
        self.id = id
        self.main = main
        self.description = description
        self.icon = icon
    }
}

class Wind: Codable {
    let speed, deg: Double

    init(speed: Double, deg: Double) {
        self.speed = speed
        self.deg = deg
    }
}
