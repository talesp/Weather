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
