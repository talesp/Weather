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

class Clouds: Codable {
    let cloudiness: Int

    enum CodingKeys: String, CodingKey {
        case cloudiness = "all"
    }

    init(cloudiness: Int) {
        self.cloudiness = cloudiness
    }
}

class Coordinates: NSObject, Codable {
    let lon, lat: Double?

    init(lon: Double?, lat: Double?) {
        self.lon = lon
        self.lat = lat
    }
}

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

class Weather: Codable {
    let id: Int
    let weatherCondition: WeatherCondition
    let description: WeatherDescription
    let icon: Icon

    init(id: Int, main: WeatherCondition, description: WeatherDescription, icon: Icon) {
        self.id = id
        self.weatherCondition = main
        self.description = description
        self.icon = icon
    }

    enum CodingKeys: String, CodingKey {
        case id, description, icon
        case weatherCondition = "main"
    }
}

class Rain: Codable {
    let threeHoursVolume: Double?

    enum CodingKeys: String, CodingKey {
        case threeHoursVolume = "3h"
    }

    init(threeHoursVolume: Double?) {
        self.threeHoursVolume = threeHoursVolume
    }
}

class Snow: Codable {
    let threeHoursVolume: Double?

    enum CodingKeys: String, CodingKey {
        case threeHoursVolume = "3h"
    }

    init(threeHoursVolume: Double?) {
        self.threeHoursVolume = threeHoursVolume
    }
}

class Sys: Codable {
    let message: Double?
    let sunrise, sunset: Int?
    let pod: Pod?

    init(message: Double? = nil, sunrise: Int? = nil, sunset: Int? = nil, pod: Pod? = nil) {
        self.message = message
        self.sunrise = sunrise
        self.sunset = sunset
        self.pod = pod
    }
}

class Wind: Codable {
    let speed, deg: Double

    init(speed: Double, deg: Double) {
        self.speed = speed
        self.deg = deg
    }

    var cardinalDirection: String {
        switch self.deg {
        case 0..<11.25:
            return "N"
        case 11.25..<33.75:
            return "NNE"
        case 33.75..<56.25:
            return "NE"
        case 56.25..<78.75:
            return "ENE"
        case 78.25..<101.25:
            return "E"
        case 101.25..<123.75:
            return "ESE"
        case 123.75..<146.25:
            return "SE"
        case 146.25..<168.75:
            return "SSE"
        case 168.25..<191.25:
            return "S"
        case 191.25..<213.75:
            return "SSW"
        case 213.75..<236.25:
            return "SW"
        case 236.25..<258.75:
            return "WSW"
        case 258.75..<281.25:
            return "W"
        case 281.25..<303.75:
            return "WNW"
        case 303.75..<326.25:
            return "NW"
        case 326.25..<348.75:
            return "NNW"
        default:
            return "N"
        }
    }
}
