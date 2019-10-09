//
//  ViewController.swift
//  PasswordiOS
//
//  Created by Daniel Ramirez on 10/8/19.
//  Copyright © 2019 Daniel Ramirez. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("LoginView")
        // Do any additional setup after loading the view.
    }
    @IBAction func loginPressed(_ sender: Any) {
        APIManager.validateUser(usernameTextField.text ?? "None" , passwordTextField.text ?? "None", completion: {
            print("Completion done")
        })
    }
    

}

