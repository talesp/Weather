//
//  Sys.swift
//  Weather
//
//  Created by Tales Pinheiro De Andrade on 27/10/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation

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
