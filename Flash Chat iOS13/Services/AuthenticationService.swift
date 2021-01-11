//
//  AuthenticationService.swift
//  Flash Chat iOS13
//
//  Created by Bohirjon Akhmedov on 11/01/21.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import Foundation
import Firebase

//Mark: - AuthenticationServiceDelegate
protocol AuthenticationServiceDelegate {
    func onSignUpSuccess()
    func onSignUpFailed(errorMessage: String)
    
    func onSignInSuccess()
    func onSignInFailed(errorMessage: String)
    
    func onSignOutSuccess()
    func onSignOutFailed(errorMessage: String)
}

//Mark: - AuthenticationProtocol
protocol AuthenticationServiceProtocol {
    var authenticationServiceDelegate: AuthenticationServiceDelegate? { get set}
    
    func signUp(authenticationData: AuthenticationData)
    func signIn(authenticationData: AuthenticationData)
    func signOut()
}

//Mark: - AuthenticationService
class AuthenticationService: AuthenticationServiceProtocol {
    var authenticationServiceDelegate: AuthenticationServiceDelegate?

    func signUp(authenticationData: AuthenticationData) {
        Auth.auth().createUser(withEmail: authenticationData.email, password: authenticationData.password) { authResult, error in
            if let safeError = error{
                self.authenticationServiceDelegate?.onSignUpFailed(errorMessage: safeError.localizedDescription)
            } else {
                self.authenticationServiceDelegate?.onSignUpSuccess()
            }
        }
    }
    
    func signIn(authenticationData: AuthenticationData) {
        Auth.auth().signIn(withEmail: authenticationData.email, password: authenticationData.password) { (authResult, error) in
            if let safeError = error{
                self.authenticationServiceDelegate?.onSignInFailed(errorMessage: safeError.localizedDescription)
            } else {
                self.authenticationServiceDelegate?.onSignInSuccess()
            }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.authenticationServiceDelegate?.onSignOutSuccess()
        }
        catch let error {
            self.authenticationServiceDelegate?.onSignOutFailed(errorMessage: error.localizedDescription)
        }
    }
}
