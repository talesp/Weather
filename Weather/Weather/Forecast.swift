//
//  Forecast.swift
//  Weather
//
//  Created by Tales Pinheiro De Andrade on 21/10/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation

class Forecast: Codable {
    let cod: String
    let message: Double
    let cnt: Int
    let list: [ForecastItem]
    let city: City?

    init(cod: String, message: Double, cnt: Int, list: [ForecastItem], city: City) {
        self.cod = cod
        self.message = message
        self.cnt = cnt
        self.list = list
        self.city = city
    }
}

enum Pod: String, Codable {
    case d = "d"
    case n = "n"
}

enum WeatherDescription: String, Codable {
    case thundertormLightRain = "thunderstorm with light rain"
    case thunderStormRain = "thunderstorm with rain"
    case thunnderstormHeavyRain = "thunderstorm with heavy rain"
    case lightThunderstorm = "light thunderstorm"
    case thunderstorm = "thunderstorm"
    case heavyThunderstorm = "heavy thunderstorm"
    case raggedThunderstorm = "ragged thunderstorm"
    case thunderstormLightDrizzle = "thunderstorm with light drizzle"
    case thunderstormDrizzle = "thunderstorm with drizzle"
    case thunderstormHeavyDrizzle = "thunderstorm with heavy drizzle"

    case lightIntensityDrizzle = "light intensity drizzle"
    case drizzle = "drizzle"
    case heavyIntensityDrizzle = "heavy intensity drizzle"
    case lightIntensityDrizzleRain = "light intensity drizzle rain"
    case drizzleRain = "drizzle rain"
    case heavyIntensityDrizzleRain = "heavy intensity drizzle rain"
    case showerRainDrizzle = "shower rain and drizzle"
    case heavyShowerRainDrizzle = "heavy shower rain and drizzle"
    case showerDrizzle = "shower drizzle"

    case lightRain = "light rain"
    case moderateRain = "moderate rain"
    case heavyIntensityRain = "heavy intensity rain"
    case veryHeavyRain = "very heavy rain"
    case extremeRain = "extreme rain"
    case freezingRain = "freezing rain"
    case lightIntensityShowerRain = "light intensity shower rain"
    case showerRain = "shower rain"
    case heavyIntensityShowerRain = "heavy intensity shower rain"
    case raggedShowerRain = "ragged shower rain"

    case lightSnow = "light snow"
    case snow
    case lightRainSnow = "light rain and snow"
    case heavySnow = "heavy snow"
    case sleet
    case rainSnow = "rain and snow"
    case lightShowerSnow = "light shower snow"
    case showerSnow = "shower snow"
    case heavyShowerSnow = "heavy shower snow"

    case mist
    case smoke
    case haze
    case sandSustWhirls = "sand, dust whirls"
    case fog
    case sand
    case dust
    case volcanicAsh = "volcanic ash"
    case squalls
    case tornado

    case clearSky = "clear sky"

    case fewClouds = "few clouds"
    case scatteredClouds = "scattered clouds"
    case brokenClouds = "broken clouds"
    case overcastClouds = "overcast clouds"

}

enum Icon: String, Codable {
    case the01D = "01d"
    case the01N = "01n"
    case the02D = "02d"
    case the02N = "02n"
    case the03D = "03d"
    case the03N = "03n"
    case the04D = "04d"
    case the04N = "04n"
    case the09D = "09d"
    case the09N = "09n"
    case the10D = "10d"
    case the10N = "10n"
    case the11D = "11d"
    case the11N = "11n"
    case the13D = "13d"
    case the13N = "13n"
    case the50D = "50d"
    case the50N = "50n"
}

enum WeatherCondition: String, Codable {
    case thunderstorm = "Thunderstorm"
    case drizzle = "Drizzle"
    case rain = "Rain"
    case snow = "Snow"
    case clear = "Clear"
    case clouds = "Clouds"
    case mist = "Mist"
}
