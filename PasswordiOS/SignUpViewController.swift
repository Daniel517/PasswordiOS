//
//  SignUpViewController.swift
//  PasswordiOS
//
//  Created by Daniel Ramirez on 10/14/19.
//  Copyright © 2019 Daniel Ramirez. All rights reserved.
//

import UIKit
import TextFieldEffects

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
            "username" : "User1510",
            "password" : "User1"
        ]
        if passwordConfirmed() {
            APIManager.signUp(parameters, completion: { status in
                print("completed")
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
        return false
    }
}
