//
//  MainDataModel.swift
//  Fox Weather
//
//  Created by Joseph Mikko Mañoza on 20/02/2020.
//  Copyright © 2020 Joseph Mikko Mañoza. All rights reserved.
//

import Foundation
import SwiftyJSON

class MainDataModel {
    var temp: Double?
    var feels_like: Double?
    var temp_min: Double?
    var temp_max: Double?
    var pressure: Double?
    var humidity: Int?
    
    // MARK: Instance Method
    func loadFromDictionary(_ dict: [String: JSON]) {
        
        if let data = dict["temp"]?.doubleValue {
            self.temp = data
        }
        if let data = dict["feels_like"]?.doubleValue {
            self.feels_like = data
        }
        if let data = dict["temp_min"]?.doubleValue {
            self.temp_min = data
        }
        if let data = dict["temp_max"]?.doubleValue {
            self.temp_max = data
        }
        if let data = dict["pressure"]?.doubleValue {
            self.pressure = data
        }
        if let data = dict["humidity"]?.intValue {
            self.humidity = data
        }
    }
    
    // MARK: Class Method
    class func build(_ dict: [String: JSON]) -> MainDataModel {
        let mainData = MainDataModel()
        mainData.loadFromDictionary(dict)
        return mainData
    }
}

