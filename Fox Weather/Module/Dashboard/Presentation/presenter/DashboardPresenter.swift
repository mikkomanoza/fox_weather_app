//
//  DashboardPresenter.swift
//  Fox Weather
//
//  Created by Joseph Mikko Mañoza on 19/02/2020.
//  Copyright © 2020 Joseph Mikko Mañoza. All rights reserved.
//

import Foundation

// MARK: - Setup View Data

struct CurrentWeatherViewData {
    let main: String
    let description: String
    let icon: String
}

struct MainViewData {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Double
    let humidity: Int
}

// MARK: - Setup View with Object Protocol

protocol CurrentWeatherView: NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func setCurrentWeather(weatherData: [CurrentWeatherViewData])
    func setMainData(mainData: MainViewData)
    func setEmptyPublicSession()
}

// MARK: - Setup Presenter

class DashboardPresenter {
    
    private let currentWeatherService: CurrentWeatherService
    weak private var currentWeatherView : CurrentWeatherView?
    
    init(currentWeatherService: CurrentWeatherService) {
        self.currentWeatherService = currentWeatherService
    }
    
    func attachView(view: CurrentWeatherView) {
        currentWeatherView = view
    }
    
    func detachView() {
        currentWeatherView = nil
    }
    
    func getWeatherData() {
        self.currentWeatherView?.startLoading()
        
        currentWeatherService.callAPIGetCurrentWeather(onSuccess: { (weatherData) in
        
            self.currentWeatherView?.finishLoading()
            
            if (weatherData.count == 0) {
                self.currentWeatherView?.setEmptyPublicSession()
            } else {
                let mappedWeatherData = weatherData.map {
                    return CurrentWeatherViewData(main: "\($0.main!)", description: "\($0.description!)", icon: "\($0.icon!)")
                }
                
                self.currentWeatherView?.setCurrentWeather(weatherData: mappedWeatherData)
            }
            
        }) { (errorMessage) in
            debugPrint(errorMessage)
            self.currentWeatherView?.finishLoading()
        }
    }
    
    func getMainData() {
        self.currentWeatherView?.startLoading()
        
        currentWeatherService.callAPIGetCurrentWeatherWithMainData(onSuccess: { (mainData) in
        
            self.currentWeatherView?.finishLoading()
            
            if (mainData.humidity == 0) {
                self.currentWeatherView?.setEmptyPublicSession()
            } else {
                let mappedMainData = MainViewData(temp: mainData.temp ?? 0.0, feels_like: mainData.feels_like ?? 0.0, temp_min: mainData.temp_min ?? 0.0, temp_max: mainData.temp_max ?? 0.0, pressure: mainData.pressure ?? 0.0, humidity: mainData.humidity ?? 0)
                self.currentWeatherView?.setMainData(mainData: mappedMainData)
            }
            
        }) { (errorMessage) in
            debugPrint(errorMessage)
            self.currentWeatherView?.finishLoading()
        }
    }
}

