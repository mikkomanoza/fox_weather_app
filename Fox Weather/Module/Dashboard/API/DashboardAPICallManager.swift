//
//  DashboardAPICallManager.swift
//  Fox Weather
//
//  Created by Joseph Mikko Mañoza on 19/02/2020.
//  Copyright © 2020 Joseph Mikko Mañoza. All rights reserved.
//

import Alamofire
import SwiftyJSON
import Foundation

let WEATHER_API_BASE_URL = "http://api.openweathermap.org/data/2.5/weather?q="
let API_KEY = "&appid=c5056ce89fa6dbef7f3dbee7c890b99f"
let CURRENT_CITY = "Manila"

class DashboardAPICallManager {
    
    static let instance = DashboardAPICallManager()
    
    enum RequestMethod {
        case get
    }
    
    enum Endpoint: String {
        case currentWeather = "Manila&appid=c5056ce89fa6dbef7f3dbee7c890b99f"
    }
    
    // MARK: Current Weather API
    func callAPIGetCurrentWeather(onSuccess successCallback: ((_ weatherData: [WeatherDataModel]) -> Void)?,
                          onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        
        // Build URL
        let url = WEATHER_API_BASE_URL + Endpoint.currentWeather.rawValue
        
        print("ito ang url: \(url)")
        
        // call API
        self.createRequest(
            url, method: .post, encoding: JSONEncoding.default,
            onSuccess: {(responseObject: JSON) -> Void in
                // Create dictionary
                if let responseDict = responseObject["weather"].arrayObject {
                   let publicSessionDict = responseDict as! [[String:AnyObject]]

                    // Create object
                    var data = [WeatherDataModel]()
                    for item in publicSessionDict {
                        let single = WeatherDataModel.build(item)
                        data.append(single)
                    }

                    // Fire callback
                    successCallback?(data)
                } else {
                    failureCallback?("An error has occured.")
                }
            },
            onFailure: {(errorMessage: String) -> Void in
                failureCallback?(errorMessage)
            }
        )
    }
    
    func callAPIGetCurrentWeatherWithMainData(onSuccess successCallback: ((_ mainData: MainDataModel) -> Void)?,
                           onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
         
         // Build URL
         let url = WEATHER_API_BASE_URL + Endpoint.currentWeather.rawValue
         
         print("ito ang url: \(url)")
         
         // call API
         self.createRequest(
             url, method: .post, encoding: JSONEncoding.default,
             onSuccess: {(responseObject: JSON) -> Void in
                // Create dictionary
                if let mainDataDict = responseObject["main"].dictionary {
                   let mainData = MainDataModel.build(mainDataDict)
                   successCallback?(mainData)
                }
             },
             onFailure: {(errorMessage: String) -> Void in
                 failureCallback?(errorMessage)
             }
         )
     }
    
    
    // MARK: Request Handler
    // Create request
    func createRequest(
        _ url: String,
        method: HTTPMethod,
        encoding: JSONEncoding,
        onSuccess successCallback: ((JSON) -> Void)?,
        onFailure failureCallback: ((String) -> Void)?
        ) {
        
        Alamofire.request(url, method: method, encoding: encoding).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                successCallback?(json)
            case .failure(let error):
                if let callback = failureCallback {
                    // Return
                    callback(error.localizedDescription)
                }
            }
        }
    }
}
