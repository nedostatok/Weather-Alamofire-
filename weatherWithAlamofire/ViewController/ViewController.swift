//
//  ViewController.swift
//  weatherWithAlamofire
//
//  Created by User on 02.09.2020.
//  Copyright © 2020 sad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var bgView: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var skyLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var imageViev: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var hourlyWeaterArray = [WeatherModel]()
    var currentlWeather: Currently?

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchWeather()
        fetchCurrentlyWeather()
        customizeDateLabel()
        createBlurEffect()
    }
    
    func fetchWeather() {
        NetworkService.shared.requestHourlyWeather { (response) in
            switch response {
            case let .success(arrayOfhourly):
                self.hourlyWeaterArray = arrayOfhourly
                
                self.weatherIcon()
                
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.collectionView.reloadData()
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func fetchCurrentlyWeather() {
        NetworkService.shared.getCurrently { (response) in
            switch response {
            case let .success(currently):
                self.currentlWeather = currently
                
                self.customizeSkyLabel()
                
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func customizeSkyLabel() {
        let currently = currentlWeather
        
        guard let temp = currently?.temperatureC, let sky = currently?.sky else { return }
        let strTemp = String(Int(temp))
        
        skyLabel.text = sky
        tempLabel.text = strTemp + "˚"
        
    }
    
    func weatherIcon() {
        guard let text = skyLabel.text else { return }
        
        switch text {
        case "Mostly Cloudy":
            imageViev.image = UIImage(named: "partly cloudy")
        case "Partly cloudy":
            imageViev.image = UIImage(named: "partly cloudy")
        case "Overcast":
            imageViev.image = UIImage(named: "cloudy")
        case "Clear":
            imageViev.image = UIImage(named: "sunnyy")
        case "Light Rain":
            imageViev.image = UIImage(named: "rain")
        case "Rain":
            imageViev.image = UIImage(named: "rain")
            
        default:
            imageViev.image = nil
        }
    }
    
    func createBlurEffect() {
        let blur = UIBlurEffect(style: .systemUltraThinMaterialDark)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.frame = bgView.bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        bgView.addSubview(blurView)
    }
    
    func customizeDateLabel() {
        let date = Date()
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let currentDate = dateFormatter.string(from: date)
        dateLabel.text = currentDate
    }
}

extension ViewController: UICollectionViewDelegate{}
extension ViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hourlyWeaterArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CollectionViewCell else { return UICollectionViewCell() }
        
        let hourly = hourlyWeaterArray[indexPath.row]
        
        cell.customizeCell(model: hourly)
        
        return cell
    }
}



