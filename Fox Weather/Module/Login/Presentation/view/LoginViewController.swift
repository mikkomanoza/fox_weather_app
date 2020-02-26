//
//  LoginViewController.swift
//  Fox Weather
//
//  Created by Joseph Mikko Mañoza on 05/02/2020.
//  Copyright © 2020 Joseph Mikko Mañoza. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let presenter = LoginPresenter(loginService: LoginService())
    var loginDataToDisplay: LoginViewData?
    
    var userName: String {
        return userNameTextField.text ?? ""
    }
    
    var password: String {
        return passwordTextField.text ?? ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func login(_ sender: UIButton) {
        presenter.attachView(view: self)
        presenter.getLogin(withUsername: userName, password: password)
    }
}

extension LoginViewController: LoginView {
    func setLogin(user: LoginViewData) {
        loginDataToDisplay = user
        performSegue(withIdentifier: "showPublicSession", sender: self)
        print("UserData: - \(user)")
    }
    
    func startLoading() {
        
    }
    
    func finishLoading() {
        
    }
    
    func setEmptyLogin() {
        
    }
}
