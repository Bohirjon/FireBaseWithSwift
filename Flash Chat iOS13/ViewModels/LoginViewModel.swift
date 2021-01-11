//
//  LoginViewModel.swift
//  Flash Chat iOS13
//
//  Created by Bohirjon Akhmedov on 11/01/21.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import Foundation

protocol LoginDelegate {
    func failed(error: String)
    func success()
    
}

class LoginViewModel {
    private var authenticationService: AuthenticationServiceProtocol
    private var loginDelegate: LoginDelegate
    
    init(authenticationService: AuthenticationServiceProtocol, loginDelegate: LoginDelegate) {
        self.authenticationService = authenticationService
        self.loginDelegate = loginDelegate
        self.authenticationService.authenticationServiceDelegate = self
    }
    
    func signUp(email: String, password: String)  {
        let authenticationData = AuthenticationData(email: email, password: password)
        authenticationService.signUp(authenticationData: authenticationData)
        
    }
    
    func signIn(email: String, password: String)  {
        let authenticationData = AuthenticationData(email: email, password: password)
        authenticationService.signIn(authenticationData: authenticationData)
    }
    
    func signOut() {
        authenticationService.signOut()
    }
}

//Mark: - AuthenticationServiceDelegate
extension LoginViewModel : AuthenticationServiceDelegate {
    func onSignUpSuccess() {
        DispatchQueue.main.async {
            self.loginDelegate.success()
        }
    }
    
    func onSignUpFailed(errorMessage: String) {
        DispatchQueue.main.async {
            self.loginDelegate.failed(error: "Failed to sign up, \(errorMessage)")
        }
    }
    
    func onSignInSuccess() {
        DispatchQueue.main.async {
            self.loginDelegate.success()
        }
    }
    
    func onSignInFailed(errorMessage: String) {
        DispatchQueue.main.async {
            self.loginDelegate.failed(error: "Sign in failed, \(errorMessage)")
        }
    }
    
    func onSignOutSuccess() {
        DispatchQueue.main.async {
            self.loginDelegate.success()
        }
    }
    
    func onSignOutFailed(errorMessage: String) {
        DispatchQueue.main.async {
            self.loginDelegate.failed(error: "Sign out failed, \(errorMessage)")
        }
    }
}
