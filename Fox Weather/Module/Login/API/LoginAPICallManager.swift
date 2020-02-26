//
//  LoginAPICallManager.swift
//  Fox Weather
//
//  Created by Joseph Mikko Mañoza on 20/02/2020.
//  Copyright © 2020 Joseph Mikko Mañoza. All rights reserved.
//

import Alamofire
import SwiftyJSON
import Foundation

let userToken = ""
let API_BASE_URL = "http://developers.studenttriangle.com"
let adminToken = ""

class LoginAPICallManager {
    
    let header: HTTPHeaders = ["Accept": "application/json", "Authorization": "Bearer \(adminToken)"]
    var params: [String: Any] = [:]
    
    static let instance = LoginAPICallManager()
    
    enum RequestMethod {
        case post
    }
    
    enum Endpoint: String {
        case login = "/api/authenticate/local"
    }
    
    // MARK: Public Session API
    func callAPILogin(username: String, password: String,
                          onSuccess successCallback: ((_ user: User) -> Void)?,
                          onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        
        // Build URL
        let url = API_BASE_URL + Endpoint.login.rawValue
        
        params = ["username": username, "password": password]
        
        // call API
        self.createRequest(
            url, method: .post, headers: header, parameters: params, encoding: JSONEncoding.default,
            onSuccess: {(responseObject: JSON) -> Void in
                
                let statusCode = responseObject["status"].intValue
                
                switch statusCode {
                case 200:
                    // Create dictionary
                    if let loginDataDict = responseObject["data"].dictionary {
                       let loginData = User.build(loginDataDict)
                       successCallback?(loginData)
                    }
                    
                    break
                case 204:
                    failureCallback?("An error has occured. statusCode == 204")
                    break
                case 400...500:
                    failureCallback?("An error has occured. statusCode == 400...500")
                    break
                default:
                    failureCallback?("An error has occured.")
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
        headers: [String: String],
        parameters: [String: Any],
        encoding: JSONEncoding,
        onSuccess successCallback: ((JSON) -> Void)?,
        onFailure failureCallback: ((String) -> Void)?
        ) {
        
        Alamofire.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers).responseJSON { response in
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
