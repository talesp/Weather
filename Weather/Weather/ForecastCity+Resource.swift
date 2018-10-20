//
//  ForecastCity+Resource.swift
//  Weather
//
//  Created by Tales Pinheiro De Andrade on 20/10/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation
enum SystemOfUnits {
    case imperialSystem
    case international

    init(usesMetricSystem: Bool) {
        if usesMetricSystem {
            self = .international
        }
        else {
            self = .imperialSystem
        }
    }
}

extension ForecastCity {

    static private let pathURLString = "weather"
    private(set) static var baseURL: URL = WeatherAPIConfig.baseURL
    
    static func resource(for coordinates: Coordinates, units: SystemOfUnits) -> Resource<ForecastCity> {
        var components = URLComponents(url: ForecastCity.baseURL, resolvingAgainstBaseURL: true)

        components?.queryItems?.append(URLQueryItem(name: "lat", value: "\(coordinates.lat)"))
        components?.queryItems?.append(URLQueryItem(name: "lon", value: "\(coordinates.lon)"))
        switch units {
        case .imperialSystem:
            components?.queryItems?.append(URLQueryItem(name: "units", value: "imperial"))
        default:
            components?.queryItems?.append(URLQueryItem(name: "units", value: "metric"))
        }
        let url = components?.url?.appendingPathComponent(ForecastCity.pathURLString) !! "Something went wrong"
        return Resource(url: url)
    }
}
