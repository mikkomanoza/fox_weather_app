//
//  User.swift
//  Fox Weather
//
//  Created by Joseph Mikko Mañoza on 19/02/2020.
//  Copyright © 2020 Joseph Mikko Mañoza. All rights reserved.
//

import Foundation
import SwiftyJSON

class User {
    var id: Int?
    var name: String?
    var token: String?
    var email: String?
    
    // MARK: Instance Method
    func loadFromDictionary(_ dict: [String: JSON]) {
        if let data = dict["id"]?.intValue {
            self.id = data
        }
        if let data = dict["name"]?.stringValue {
            self.name = data
        }
        if let data = dict["api_token"]?.stringValue {
            self.token = data
        }
        if let data = dict["email"]?.stringValue {
            self.email = data
        }
    }
    
    // MARK: Class Method
    class func build(_ dict: [String: JSON]) -> User {
        let user = User()
        user.loadFromDictionary(dict)
        return user
    }
}
