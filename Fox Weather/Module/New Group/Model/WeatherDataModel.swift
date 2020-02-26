//
//  DashboardData.swift
//  Fox Weather
//
//  Created by Joseph Mikko Mañoza on 19/02/2020.
//  Copyright © 2020 Joseph Mikko Mañoza. All rights reserved.
//

import Foundation

class WeatherDataModel {
    var id: Int?
    var main: String?
    var description: String?
    var icon: String?
    
    // MARK: Instance Method
    func loadFromDictionary(_ dict: [String: AnyObject]) {
        if let data = dict["id"] as? Int {
            self.id = data
        }
        if let data = dict["main"] as? String {
            self.main = data
        }
        if let data = dict["description"] as? String {
            self.description = data
        }
        if let data = dict["icon"] as? String {
            self.icon = data
        }
    }
    
    // MARK: Class Method
    class func build(_ dict: [String: AnyObject]) -> WeatherDataModel {
        let weatherData = WeatherDataModel()
        weatherData.loadFromDictionary(dict)
        return session
    }
}
