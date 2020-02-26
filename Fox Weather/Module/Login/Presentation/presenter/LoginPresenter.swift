//
//  LoginPresenter.swift
//  Fox Weather
//
//  Created by Joseph Mikko Mañoza on 19/02/2020.
//  Copyright © 2020 Joseph Mikko Mañoza. All rights reserved.
//

import Foundation

// MARK: - Setup View Data

struct LoginViewData {
    let id: Int
    let name: String
    let token: String
    let email: String
}

// MARK: - Setup View with Object Protocol

protocol LoginView: NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func setLogin(user: LoginViewData)
    func setEmptyLogin()
}

// MARK: - Setup Presenter

class LoginPresenter {
    
    private let loginService: LoginService
    weak private var loginView : LoginView?
    
    init(loginService: LoginService) {
        self.loginService = loginService
    }
    
    func attachView(view: LoginView) {
        loginView = view
    }
    
    func detachView() {
        loginView = nil
    }
    
    func getLogin(withUsername: String, password: String) {
        self.loginView?.startLoading()
        
        loginService.callAPILogin(username: withUsername, password: password, onSuccess: { (user) in
    
            self.loginView?.finishLoading()
            
            if (user.id == 0) {
                self.loginView?.setEmptyLogin()
            } else {
                let mappedUser = LoginViewData(id: user.id ?? 0, name: user.name ?? "Empty Name", token: user.token ?? "Empty Token", email: user.email ?? "Empty Email")
                self.loginView?.setLogin(user: mappedUser)
            }
            
        }) { (errorMessage) in
            debugPrint("getLogin() error: \(errorMessage)")
            self.loginView?.finishLoading()
        }
    }
}
