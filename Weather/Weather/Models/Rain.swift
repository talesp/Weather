//
//  Rain.swift
//  Weather
//
//  Created by Tales Pinheiro De Andrade on 27/10/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation

class Rain: Codable {
    let threeHoursVolume: Double?

    enum CodingKeys: String, CodingKey {
        case threeHoursVolume = "3h"
    }

    init(threeHoursVolume: Double?) {
        self.threeHoursVolume = threeHoursVolume
    }
}
