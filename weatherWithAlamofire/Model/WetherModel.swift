//
//  WetherModel.swift
//  weatherWithAlamofire
//
//  Created by User on 07.09.2020.
//  Copyright © 2020 sad. All rights reserved.
//

import Foundation
import Alamofire

enum ValueOrError {
    case Error(AFError)
    case Value([WeatherModel],Currently)
}

struct WeatherModel {
    let temperatureF: Double
    var temperatureC: Double {
        get {
            return (self.temperatureF - 32) / 1.8
        }
    }
    
    let sky: String
    var time: Date
    
    func timeConverter() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        return dateFormatter.string(from: time)
    }
}

struct Currently {
    let temperatureF: Double
    var temperatureC: Double {
        get {
            return (self.temperatureF - 32) / 1.8
        }
    }
    let sky: String
}
