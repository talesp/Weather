//
// Created by Tales Pinheiro De Andrade on 2018-11-03.
// Copyright (c) 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import UIKit

class WeatherDetailCell: UITableViewCell, Reusable {

    private lazy var weatherView: WeatherDetailView = {
        let view = WeatherDetailView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    func setup(model: ForecastItem) {
        weatherView.setup(model: model)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewConfiguration()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WeatherDetailCell: ViewConfiguration {
    func buildViewHierarchy() {
        self.contentView.addSubview(weatherView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            weatherView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor),
            weatherView.heightAnchor.constraint(equalTo: self.contentView.heightAnchor),
            weatherView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            weatherView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
        ])
    }
}
