//
// Created by Tales Pinheiro De Andrade on 2018-11-03.
// Copyright (c) 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import UIKit

extension UITableView {

    func register<T: UITableViewCell>(reusableCell: T.Type) where T: Reusable {
        self.register(reusableCell, forCellReuseIdentifier: T.identifier)
    }

    func dequeueCell<T: UITableViewCell>(for indexPath: IndexPath, cellType: T.Type = T.self) -> T where T: Reusable {
            guard let cell = dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T else {
                fatalError("Failed to dequeue a cell of type \(T.self) for index path \(indexPath). " +
                        "Maybe you should register it first?")
            }
        return cell
    }
}
