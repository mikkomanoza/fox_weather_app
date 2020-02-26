//
//  DashboardViewController.swift
//  Fox Weather
//
//  Created by Joseph Mikko Mañoza on 19/02/2020.
//  Copyright © 2020 Joseph Mikko Mañoza. All rights reserved.
//

import Foundation
import SDWebImage
import UIKit

class DashboardViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var mainCurrentWeatherLabel: UILabel!
    @IBOutlet weak var subCurrentWeatherLabel: UILabel!
    
    let presenter = DashboardPresenter(currentWeatherService: CurrentWeatherService())
    var weatherDataToDisplay = [CurrentWeatherViewData]()
    
    override func viewDidLoad() {
        activityIndicator.hidesWhenStopped = true
        presenter.attachView(view: self)
        presenter.getWeatherData()
        presenter.getMainData()
    }
    
    // MARK: - SetUp UIs
    
    private func setUpImage(icon: String) {
        let image_URL = "http://openweathermap.org/img/wn/\(icon)@2x.png"
        self.currentWeatherImage.sd_setImage(with: URL(string: image_URL)!, completed: nil)
    }
    
    private func setUpLabel(mainWeatherStr: String, subWeatherStr: String) {
        self.mainCurrentWeatherLabel.text = mainWeatherStr
        self.subCurrentWeatherLabel.text = subWeatherStr
    }
}

extension DashboardViewController: CurrentWeatherView {
    
    func setMainData(mainData: MainViewData) {
        print("mainData: \(mainData)")
    }
    
    func setCurrentWeather(weatherData: [CurrentWeatherViewData]) {
        self.weatherDataToDisplay = weatherData
        self.setUpImage(icon: weatherData[0].icon)
        self.setUpLabel(mainWeatherStr: weatherData[0].main, subWeatherStr: weatherData[0].description)
    }
    
    func startLoading() {
        activityIndicator.startAnimating()
    }
      
    func finishLoading() {
        activityIndicator.stopAnimating()
    }
    
    func setEmptyPublicSession() {
        
    }
}
