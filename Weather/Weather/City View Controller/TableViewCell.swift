//
//  TableViewCell.swift
//  Weather
//
//  Created by Tales Pinheiro De Andrade on 22/10/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var weatherConditionnImageView: UIImageView!
    @IBOutlet var weatherConditionDescriptionLabel: UILabel!
    @IBOutlet var minTempLabel: UILabel!
    @IBOutlet var maxTempLabel: UILabel!
    @IBOutlet var rainLabel: UILabel!
    @IBOutlet var snowLabel: UILabel!
    @IBOutlet var windLabel: UILabel!
    @IBOutlet var pressureLabel: UILabel!
    @IBOutlet var humidityLabel: UILabel!
    @IBOutlet var cloudsLabel: UILabel!

    var model: ForecastItem?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setup(model: ForecastItem) {
        self.model = model
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("hm")
        self.timeLabel.text = dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(self.model?.dt ?? 0)))
        if let weather = self.model?.weather.first {
            self.weatherConditionnImageView.image = UIImage(named: weather.icon.rawValue)
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
}
