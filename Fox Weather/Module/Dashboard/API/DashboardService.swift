//
//  DashboardService.swift
//  Fox Weather
//
//  Created by Joseph Mikko Mañoza on 19/02/2020.
//  Copyright © 2020 Joseph Mikko Mañoza. All rights reserved.
//

import Foundation

class CurrentWeatherService {
    public func callAPIGetCurrentWeather(onSuccess successCallback: ((_ weatherData: [WeatherDataModel]) -> Void)?, onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        DashboardAPICallManager.instance.callAPIGetCurrentWeather (
            onSuccess: { (weatherData) in
                successCallback?(weatherData)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }
    
    public func callAPIGetCurrentWeatherWithMainData(onSuccess successCallback: ((_ mainData: MainDataModel) -> Void)?, onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        DashboardAPICallManager.instance.callAPIGetCurrentWeatherWithMainData (
            onSuccess: { (mainData) in
                successCallback?(mainData)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }
}

