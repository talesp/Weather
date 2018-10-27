//
//  Weather.swift
//  Weather
//
//  Created by Tales Pinheiro De Andrade on 27/10/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation

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
