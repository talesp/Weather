//
//  WeatherDescription.swift
//  Weather
//
//  Created by Tales Pinheiro De Andrade on 27/10/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation

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
