//
//  CollectionViewCell.swift
//  weatherWithAlamofire
//
//  Created by User on 07.09.2020.
//  Copyright © 2020 sad. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var imageLabel: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    
    func customizeCell(model: WeatherModel) {
        timeLabel.text = model.timeConverter()
        tempLabel.text = String(Int(model.temperatureC)) + "º"
        
        switch model.sky {
        case "Mostly Cloudy":
            self.imageLabel.image = UIImage(named: "partly cloudy")
        case "Partly Cloudy":
            self.imageLabel.image = UIImage(named: "partly cloudy")
        case "Overcast":
            self.imageLabel.image = UIImage(named: "cloudy")
        case "Clear":
            self.imageLabel.image = UIImage(named: "sunnyy")
        case "Light Rain":
            self.imageLabel.image = UIImage(named: "rain")
        case "Rain":
            self.imageLabel.image = UIImage(named: "rain")
        default:
            self.imageLabel.image = nil
        }
    }
}
