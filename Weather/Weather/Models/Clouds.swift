//
//  Clouds.swift
//  Weather
//
//  Created by Tales Pinheiro De Andrade on 27/10/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation

class Clouds: Codable {
    let cloudiness: Int

    enum CodingKeys: String, CodingKey {
        case cloudiness = "all"
    }

    init(cloudiness: Int) {
        self.cloudiness = cloudiness
    }
}
