//
//  Contants.swift
//  Fox Weather
//
//  Created by Joseph Mikko Mañoza on 05/02/2020.
//  Copyright © 2020 Joseph Mikko Mañoza. All rights reserved.
//

import Foundation

struct Constants {
    
    struct CellIdentifiers {
        static let DRAWER_CELL = "drawerCell"
    }
    
    struct StoryboardIdentifiers {
       static let MAIN_VIEW = "Main"
       static let DRAWER_VIEW = "Left"
    }
    
    static let drawerHeaderHeight = Float(70)
    static let cityName = "Manila"
    static let baseUrl = "http://api.openweathermap.org/data/2.5/weather?q"
    static let apiKey = "c5056ce89fa6dbef7f3dbee7c890b99f"
    
    static let fullURL = "http://api.openweathermap.org/data/2.5/weather?q=Manila&appid=c5056ce89fa6dbef7f3dbee7c890b99f"
}
