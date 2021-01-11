//
//  RegisterViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var loginViewModel: LoginViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginViewModel = LoginViewModel(authenticationService: AuthenticationService(), loginDelegate: self)
        activityIndicator!.isHidden = true
    }
    
    @IBAction func registerPressed(_ sender: UIButton) {
        if let email = emailTextfield.text , let password = passwordTextfield.text {
            loginViewModel!.signUp(email: email, password: password)
            startLoading()
        }
    }
}


//Mark: - LoginDelegate
extension RegisterViewController: LoginDelegate{
    func failed(error: String) {
        stopLoading()
        let alerController = UIAlertController(title: "Signing up failed", message: error, preferredStyle: .alert)
        alerController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alerController, animated: true, completion: nil)
    }
    
    func success() {
        stopLoading()
        self.performSegue(withIdentifier: "RegisterToChat", sender: self)
    }
}


//Mark: - LoadingIndicator
extension RegisterViewController {
    func startLoading() {
        activityIndicator!.isHidden = false
        activityIndicator!.startAnimating()
    }
    
    func stopLoading() {
        activityIndicator!.isHidden = true
        activityIndicator!.stopAnimating()
    }
}
