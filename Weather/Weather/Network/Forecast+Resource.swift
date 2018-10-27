//
//  Forecast+Resource.swift
//  Weather
//
//  Created by Tales Pinheiro De Andrade on 23/10/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation

extension Forecast {

    static private let pathURLString = "forecast"
    private(set) static var baseURL: URL = WeatherAPIConfig.baseURL

    static func resource(for coordinates: Coordinates, units: SystemOfUnits) -> Resource<Forecast> {
        var components = URLComponents(url: self.baseURL, resolvingAgainstBaseURL: true)

        guard let lat = coordinates.lat, let lon = coordinates.lon else { fatalError() }
        components?.queryItems?.append(URLQueryItem(name: "lat", value: "\(lat)"))
        components?.queryItems?.append(URLQueryItem(name: "lon", value: "\(lon)"))
        switch units {
        case .imperialSystem:
            components?.queryItems?.append(URLQueryItem(name: "units", value: "imperial"))
        default:
            components?.queryItems?.append(URLQueryItem(name: "units", value: "metric"))
        }
        let url = components?.url?.appendingPathComponent(self.pathURLString) !! "Something went wrong"
        return Resource(url: url)
    }
}
