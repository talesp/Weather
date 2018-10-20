//
//  WeatherAPIConfig.swift
//  Weather
//
//  Created by Tales Pinheiro De Andrade on 20/10/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation

struct WeatherAPIConfig {

    /// FIXME: Use the following command to ignore local changes to this file.
    /// FIXME: After that, change the values below for `apikey` with your own.
    /// `git update-index --skip-worktree Weather/Network/WeatherAPIConfig.swift`
    /// If, after that, you want to push any change, undo the command above with the command below
    /// `git update-index --no-skip-worktree Weather/Network/WeatherAPIConfig.swift`
    #error("Follow the procedure above!")
    static let apikey = "<#apiKey#>"

    static let baseURLString = "http://api.openweathermap.org/data/2.5/?appid=\(WeatherAPIConfig.apikey)"
    static let baseURL = URL(string: WeatherAPIConfig.baseURLString) !! "Verify the address for base URL"
}
