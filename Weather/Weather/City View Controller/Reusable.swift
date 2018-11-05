//
// Created by Tales Pinheiro De Andrade on 2018-11-03.
// Copyright (c) 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import UIKit

protocol Reusable {
    static var identifier: String { get }
}

extension Reusable where Self: UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}