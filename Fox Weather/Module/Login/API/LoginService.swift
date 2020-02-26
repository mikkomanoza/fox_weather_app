//
//  LoginService.swift
//  Fox Weather
//
//  Created by Joseph Mikko Mañoza on 19/02/2020.
//  Copyright © 2020 Joseph Mikko Mañoza. All rights reserved.
//

import Foundation

class LoginService {
    public func callAPILogin(username: String, password: String,
                             onSuccess successCallback: ((_ user: User) -> Void)?,
                             onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        
        LoginAPICallManager.instance.callAPILogin (
            username: username, password: password, onSuccess: { (session) in
                successCallback?(session)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }
}
