//
//  HttpMethod.swift
//  Weather
//
//  Created by Tales Pinheiro De Andrade on 20/10/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation

enum HttpMethod<Body> {
    case get
    case post(Body)
}

extension HttpMethod {
    var method: String {
        switch self {
        case .get:
            return "GET"
        case .post:
            return "POST"
        }
    }

    func map<B>(function: (Body) -> B) -> HttpMethod<B> {
        switch self {
        case .get:
            return .get
        case .post(let body):
            return .post(function(body))
        }

    }
}
