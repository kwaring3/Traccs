//
//  UserSession.swift
//  Traccs
//
//  Created by Kevin Waring on 3/5/19.
//  Copyright © 2019 Kevin Waring. All rights reserved.
//

import Foundation
import FirebaseAuth

protocol UserSessionAccountCreationDelegate: AnyObject {
    func didCreateAccount(_ userSession: UserSession, user: User)
    func didRecieveErrorCreatingAccount(userSession: UserSession, error: Error)
}
protocol UserSessionSignOutDelegate: AnyObject {
    func didRecieveSignOutError(_ usersession: UserSession, error: Error)
    func didSignOut(_ usersessions: UserSession)
}
protocol UserSessionSignInDelegate: AnyObject {
    func didRecieveSignInError(_ usersession: UserSession, error: Error)
    func didSignInExistingUser(_ usersession: UserSession, user: User)
}

final class UserSession {
    
    weak var userSessionAccountDelegate: UserSessionAccountCreationDelegate?
    weak var userSessionSignOutDelegate: UserSessionSignOutDelegate?
    weak var userSessionSignInDelegate: UserSessionSignInDelegate?
    
    func createNewAccount(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { (authDataResult, error) in
            if let error = error {
                self.userSessionAccountDelegate?.didRecieveErrorCreatingAccount(userSession: self, error: error)
            } else if let authDataResult = authDataResult {
                self.userSessionAccountDelegate?.didCreateAccount(self, user: authDataResult.user)
                guard let username = authDataResult.user.email?.components(separatedBy: "@").first else {
                    print("no email entered")
                    return
                }
                // add user to database
                // use the user.uid as the document id for ease of use when updating / querying current user
                DatabaseManager.firebaseDB.collection(DatabaseKeys.UsersCollectionKey)
                    .document(authDataResult.user.uid.description)
                    .setData(["userId"      : authDataResult.user.uid,
                              "email"       : authDataResult.user.email ?? "",
                              "displayName" : authDataResult.user.displayName ?? "",
                              "imageURL"    : authDataResult.user.photoURL ?? "",
                              "username"    : username
                        ], completion: { (error) in
                            if let error = error {
                                print("error adding authenticated user to the database: \(error)")
                            }
                    })
            }
        }
    }
    public func getCurrentUser() -> User? {
        return  Auth.auth().currentUser
    }
    public func signInexistingUser(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (authDataResult, error) in
            if let error = error {
                self.userSessionSignInDelegate?.didRecieveSignInError(self, error: error)
            }else if let authDataResult = authDataResult {
                self.userSessionSignInDelegate?.didSignInExistingUser(self, user: authDataResult.user)
            }
        }
    }
    public func signOut() {
        guard let _ = getCurrentUser() else {
            print("no logged user")
            return
        }
        do{
            try Auth.auth().signOut()
            userSessionSignOutDelegate?.didSignOut(self)
        } catch {
            userSessionSignOutDelegate?.didRecieveSignOutError(self, error: error)
        }
    }
}