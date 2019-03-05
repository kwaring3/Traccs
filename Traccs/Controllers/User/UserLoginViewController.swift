//
//  UserLoginViewController.swift
//  Traccs
//
//  Created by Kevin Waring on 2/11/19.
//  Copyright © 2019 Kevin Waring. All rights reserved.
//

import UIKit
import FirebaseAuth

enum AccountLoginState1 {
    case newAccount
    case existingAccount
}

class UserLoginViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var accountMessageLabel: UILabel!
    
    private var userSession: UserSession!
    
    private var tapGesture: UITapGestureRecognizer!
    
    private var accountLoginState = AccountLoginState.newAccount
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userSession = (UIApplication.shared.delegate as! AppDelegate).userSession
        userSession.userSessionAccountDelegate = self
        userSession.userSessionSignInDelegate = self
        commonInit()
        
    }
    private func commonInit() {
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        
        accountMessageLabel.isUserInteractionEnabled = true
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(gestureRecognizer:)))
        accountMessageLabel.addGestureRecognizer(tapGesture)
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        guard let email = nameTextField.text,
            let password = passwordTextField.text,
            !email.isEmpty, !password.isEmpty else {
                // TODO: show user alert
                print("email or password is required")
                return
        }
        switch accountLoginState {
        case .newAccount:
            userSession.createNewAccount(email: email, password: password)
        case .existingAccount:
            userSession.signInexistingUser(email: email, password: password)
            break
        }
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        guard let adminLogin = storyboard.instantiateViewController(withIdentifier: "userTabBarController") as? UITabBarController else {print("NO VC")
            return
    }
        present(adminLogin, animated: false, completion: nil)
    }
    
    @objc private func handleTap(gestureRecognizer: UITapGestureRecognizer) {
        accountLoginState = accountLoginState == .newAccount ? .existingAccount : .newAccount
        switch accountLoginState {
        case .newAccount:
            loginButton.setTitle("create" , for: .normal)
            accountMessageLabel.text = "Create Account"
            break
        case .existingAccount:
            loginButton.setTitle("login", for: .normal)
            accountMessageLabel.text = "Login to your account"
            break
        }
    }
}
extension UserLoginViewController: UserSessionAccountCreationDelegate {
    func didCreateAccount(_ userSession: UserSession, user: User) {
        let alertController = UIAlertController(title: "Account Created", message: "Account created using \(user.email ?? "no email entered")", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
    
    func didRecieveErrorCreatingAccount(userSession: UserSession, error: Error) {
        let alertController = UIAlertController(title: "Account Creation Error", message: "\(error.localizedDescription)", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
    
    
}
extension UserLoginViewController: UserSessionSignInDelegate {
    func didRecieveSignInError(_ usersession: UserSession, error: Error) {
        let alertController = UIAlertController(title: "Sign in error", message: error.localizedDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
    
    func didSignInExistingUser(_ usersession: UserSession, user: User) {
        let alertController = UIAlertController(title: "Welcome Back", message: "Hello", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) {alert in
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let adminLoginViewController = storyboard.instantiateViewController(withIdentifier: "AdminLoginViewController") as! AdminLoginViewController
            adminLoginViewController.modalTransitionStyle = .crossDissolve
            adminLoginViewController.modalPresentationStyle = .overFullScreen
            self.present(adminLoginViewController, animated: true )
        }
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
    
    
}
