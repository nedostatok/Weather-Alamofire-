//
//  NetWorking.swift
//  weatherWithAlamofire
//
//  Created by User on 02.09.2020.
//  Copyright © 2020 sad. All rights reserved.
//

import Foundation
import Alamofire

class NetworkService {
    static let shared = NetworkService()
    typealias HandleWeather = (Result<[WeatherModel],AFError>) -> ()
    typealias HandleCurrently = (Result<Currently,AFError>) -> ()
    
    func requestHourlyWeather(completion: @escaping HandleWeather) {
        guard let url = URL(string: "https://api.darksky.net/forecast/0a56d0a9d5527021aa16b16e36f04708/\(49.9808100),\(36.2527200)") else { return }
        
        AF.request(url).validate().responseJSON { (response) in
            
            switch response.result {
            case .success(let data):
                guard let arrayOfItems = data as? [String:Any] else { return }
                guard let hourly = arrayOfItems["hourly"] as? [String:Any] else { return }
                guard let hourlyData = hourly["data"] as? [[String:Any]] else { return }
                
                var arrayHourly = [WeatherModel]()
                
                for i in hourlyData {
                    guard let sky = i["summary"] as? String else { return }
                    guard let temperatureF =  i["temperature"] as? Double else { return }
                    guard let time = i["time"] as? Double else { return }
                    
                    let weather = WeatherModel(temperatureF: temperatureF, sky: sky, time: Date(timeIntervalSince1970: time))
                    arrayHourly.append(weather)
                    
                    completion(.success(arrayHourly))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getCurrently(completion: @escaping HandleCurrently) {
        guard let url = URL(string: "https://api.darksky.net/forecast/0a56d0a9d5527021aa16b16e36f04708/\(49.9808100),\(36.2527200)") else { return }
        
        AF.request(url).validate().responseJSON { (response) in
            switch response.result {
            case .success(let data):
                guard let arrayOfItems = data as? [String:Any] else { return }
                guard let currently = arrayOfItems["currently"] as? [String:Any] else { return }
                guard let sky = currently["summary"] as? String else { return }
                guard let temp = currently["temperature"] as? Double else { return }
                
                let currentlyItem = Currently(temperatureF: temp, sky: sky)
                
                completion(.success(currentlyItem))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

