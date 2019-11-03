//
//  SignUpViewController.swift
//  PasswordiOS
//
//  Created by Daniel Ramirez on 10/14/19.
//  Copyright © 2019 Daniel Ramirez. All rights reserved.
//

import UIKit
import TextFieldEffects
import CryptoSwift

class SignUpViewController : UIViewController {
    
    @IBOutlet weak var usernameField: HoshiTextField!
    @IBOutlet weak var passwordField: HoshiTextField!
    @IBOutlet weak var confirmPasswordField: HoshiTextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signUpPressed(_ sender: Any) {
        let parameters : [String : Any] = [
            "username" : usernameField.text!,
            "password" : passwordField.text!.sha512()
        ]
        if passwordConfirmed() {
            APIManager.signUp(parameters, completion: { status in
                switch status {
                case 0: self.successfulSignUpAlert(); break;
                case 1: self.duplicationAlert(); break;
                case 2: print("failure"); break; //Try again later message
                default: break;
                }
            })
        }
    }
    
    func passwordConfirmed() -> Bool {
        if (passwordField.text?.isEmpty ?? true) {
            return false
        }
        if passwordField.text == confirmPasswordField.text {
            return true
        }
        else {
            self.differentPasswordsAlert()
        }
        return false
    }
    
    func differentPasswordsAlert() {
        let alert = UIAlertController(title: "Passwords do not match", message: "Make sure passwords match for each field", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func successfulSignUpAlert() {
        let alert = UIAlertController(title: "Account created successfully!", message: "Continue to login", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Login", style: .default, handler: { action in
            let login = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login") as! LoginViewController
            self.present(login, animated: true, completion: nil)
        }))
        self.present(alert, animated: true)
    }
    
    func duplicationAlert() {
        let alert = UIAlertController(title: "Failure to create account", message: "Username has already been taken", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}
