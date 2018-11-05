//
//  WeatherDetailView.swift
//  Weather
//
//  Created by Tales Pinheiro De Andrade on 28/10/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import UIKit

class WeatherDetailView: UIView {

    private var tableConstraint: NSLayoutConstraint!

    private func titleLabel() -> UILabel {
        let view = UILabel(frame: .zero)
        view.font = .preferredFont(forTextStyle: .headline)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        //        view.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return view
    }

    private func valueLabel() -> UILabel {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .preferredFont(forTextStyle: .subheadline)
//        view.setContentHuggingPriority(.defaultLow, for: .horizontal)
        view.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return view
    }

    private func stackView(with titleLabel: UILabel, valueLabel: UILabel) -> UIStackView {
        let view = UIStackView(arrangedSubviews: [ titleLabel, valueLabel ])
        view.axis = .horizontal
        view.spacing = 4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }

    private lazy var timeLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = .preferredFont(forTextStyle: .title2)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setContentHuggingPriority(UILayoutPriority(252), for: .horizontal)
        return view
    }()

    private lazy var weatherConditionImageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setContentHuggingPriority(UILayoutPriority(252), for: .horizontal)
        return view
    }()

    private lazy var weatherConditionDescriptionLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = .preferredFont(forTextStyle: .title2)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setContentCompressionResistancePriority(UILayoutPriority(752), for: .horizontal)
        return view
    }()

    private lazy var headerStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            timeLabel, weatherConditionImageView, weatherConditionDescriptionLabel
            ])
        view.axis = .horizontal
        view.spacing = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var minTempTitleLabel: UILabel = {
        let view = titleLabel()
        view.text = "Min Temp"
        return view
    }()

    private lazy var minTempLabel: UILabel = {
        return valueLabel()
    }()

    private lazy var minTempStackView: UIStackView = {
        return stackView(with: self.minTempTitleLabel, valueLabel: self.minTempLabel)
    }()

    private lazy var maxTempTitleLabel: UILabel = {
        let view = titleLabel()
        view.text = "Max Temp"
        return view
    }()

    private lazy var maxTempLabel: UILabel = {
        return valueLabel()
    }()

    private lazy var maxTempStackView: UIStackView = {
        return stackView(with: self.maxTempTitleLabel, valueLabel: self.maxTempLabel)
    }()

    private lazy var temperatureStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            minTempStackView, maxTempStackView
            ])
        view.axis = .vertical
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var rainTitleLabel: UILabel = {
        let view = titleLabel()
        view.text = "Rain"
        return view
    }()

    private lazy var rainLabel: UILabel = {
        return valueLabel()
    }()

    private lazy var rainStackView: UIStackView = {
        return stackView(with: self.rainTitleLabel, valueLabel: self.rainLabel)
    }()

    private lazy var snowTitleLabel: UILabel = {
        let view = titleLabel()
        view.text = "Snow"
        return view
    }()

    private lazy var snowLabel: UILabel = {
        return valueLabel()
    }()

    private lazy var snowStackView: UIStackView = {
        return stackView(with: self.snowTitleLabel, valueLabel: self.snowLabel)
    }()

    private lazy var precipitationStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            rainStackView, snowStackView
            ])
        view.axis = .vertical
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var windTitleLabel: UILabel = {
        let view = titleLabel()
        view.text = "Wind"
        return view
    }()

    private lazy var windLabel: UILabel = {
        return valueLabel()
    }()

    private lazy var skyConditionStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            cloudsStackView, windStackView
            ])
        view.axis = .vertical
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var secondInfoBlockStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            precipitationStackView, skyConditionStackView
            ])
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.spacing = 4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var windStackView: UIStackView = {
        return stackView(with: self.windTitleLabel, valueLabel: self.windLabel)
    }()

    private lazy var pressureTitleLabel: UILabel = {
        let view = titleLabel()
        view.text = "Pressure"
        return view
    }()

    private lazy var pressureLabel: UILabel = {
        return valueLabel()
    }()

    private lazy var pressureStackView: UIStackView = {
        return stackView(with: self.pressureTitleLabel, valueLabel: self.pressureLabel)
    }()

    private lazy var humidityTitleLabel: UILabel = {
        let view = titleLabel()
        view.text = "Humidity"
        return view
    }()

    private lazy var humidityLabel: UILabel = {
        return valueLabel()
    }()

    private lazy var humidityStackView: UIStackView = {
        return stackView(with: self.humidityTitleLabel, valueLabel: self.humidityLabel)
    }()

    private lazy var pressureHumidityStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            pressureStackView, humidityStackView
            ])
        view.axis = .vertical
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var firstInfoBlockStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            temperatureStackView, pressureHumidityStackView
            ])
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.spacing = 4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var cloudsTitleLabel: UILabel = {
        let view = titleLabel()
        view.text = "Clouds"
        return view
    }()

    private lazy var cloudsLabel: UILabel = {
        return valueLabel()
    }()

    private lazy var cloudsStackView: UIStackView = {
        return stackView(with: self.cloudsTitleLabel, valueLabel: self.cloudsLabel)
    }()

    private lazy var infoBlockStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            firstInfoBlockStackView, secondInfoBlockStackView
            ])
//        view.axis = UIScreen
//            .main
//            .traitCollection
//            .verticalSizeClass == .regular ? .horizontal : .vertical
        view.spacing = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var mainContentStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            headerStackView, infoBlockStackView
            ])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.spacing = 8
        view.axis = .vertical
        view.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        view.isLayoutMarginsRelativeArrangement = true
        return view
    }()

    private(set) var model: ForecastItem?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewConfiguration()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(model: ForecastItem) {
        self.model = model
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("hm")
        self.timeLabel.text = dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(self.model?.dt ?? 0)))
        if let weather = self.model?.weather.first {
            self.weatherConditionImageView.image = UIImage(named: weather.icon.rawValue)
            self.weatherConditionDescriptionLabel.text = weather.description.rawValue.capitalized
        }
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 2
        let tempUnit = UserDefaults.standard.temperatureUnit
        self.minTempLabel.text = "\(numberFormatter.string(from: model.weatherDetails.temperatureMin as NSNumber) ?? "") \(tempUnit)"
        self.maxTempLabel.text = "\(numberFormatter.string(from: model.weatherDetails.temperatureMax as NSNumber) ?? "") \(tempUnit)"
        self.pressureLabel.text = "\(numberFormatter.string(from: model.weatherDetails.pressure as NSNumber) ?? "") hPa"
        self.humidityLabel.text = "\(numberFormatter.string(from: model.weatherDetails.humidity as NSNumber) ?? "") %"
        self.rainLabel.text = "\(numberFormatter.string(from: (model.rain?.threeHoursVolume ?? 0) as NSNumber) ?? "") mm"
        self.snowLabel.text = "\(numberFormatter.string(from: (model.snow?.threeHoursVolume ?? 0) as NSNumber) ?? "") mm"
        self.cloudsLabel.text = "\(numberFormatter.string(from: model.clouds.cloudiness as NSNumber) ?? "") %"
        self.windLabel.text = "\(model.wind.cardinalDirection) \(numberFormatter.string(from: model.wind.speed as NSNumber) ?? "") m/s"
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        let vertical = UITraitCollection(verticalSizeClass: .regular)
        UIView.animate(withDuration: 0.3) {
            self.infoBlockStackView.axis = self.traitCollection.containsTraits(in: vertical) ? .vertical : .horizontal
            self.tableConstraint.isActive = !self.traitCollection.containsTraits(in: vertical)
            self.layoutIfNeeded()
        }
    }
}

extension WeatherDetailView: ViewConfiguration {
    func buildViewHierarchy() {
        addSubview(mainContentStackView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            mainContentStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            mainContentStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            mainContentStackView.widthAnchor.constraint(equalTo: self.widthAnchor),
            mainContentStackView.heightAnchor.constraint(equalTo: self.heightAnchor)
            ])

        NSLayoutConstraint.activate([
            minTempTitleLabel.widthAnchor.constraint(equalTo: maxTempTitleLabel.widthAnchor),
            pressureTitleLabel.widthAnchor.constraint(equalTo: humidityTitleLabel.widthAnchor),
            rainTitleLabel.widthAnchor.constraint(equalTo: snowTitleLabel.widthAnchor),
            cloudsTitleLabel.widthAnchor.constraint(equalTo: windTitleLabel.widthAnchor)
            ])

        tableConstraint = temperatureStackView.widthAnchor.constraint(equalTo: precipitationStackView.widthAnchor)
    }

}
