//
//  LoginViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var activityindicator: UIActivityIndicatorView!
    
    var loginViewModel: LoginViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        loginViewModel = LoginViewModel(authenticationService: AuthenticationService(), loginDelegate: self)
        activityindicator!.isHidden = true
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        if let emial = emailTextfield.text, let password = passwordTextfield.text {
            startLoading()
            loginViewModel!.signIn(email: emial, password: password)
        }
    }
}

//Mark: - LoginDelegate
extension LoginViewController : LoginDelegate {
    func failed(error: String) {
        stopLoading()
        let alerController = UIAlertController(title: "Sign in failed", message: error, preferredStyle: .alert)
        alerController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alerController, animated: true, completion: nil)
    }
    
    func success() {
        stopLoading()
        self.performSegue(withIdentifier: "LoginToChat", sender: self)
    }
}


//Mark: - LoadingIndicator
extension LoginViewController {
    func startLoading() {
        activityindicator!.isHidden = false
        activityindicator!.startAnimating()
    }
    
    func stopLoading() {
        activityindicator!.isHidden = true
        activityindicator!.stopAnimating()
    }
}

