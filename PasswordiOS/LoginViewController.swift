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
        // Do any additional setup after loading the view.
    }
    @IBAction func loginPressed(_ sender: Any) {
        let parameters : [String : Any] = [
            "username" : usernameTextField.text!,
            "password" : passwordTextField.text!
        ]
        APIManager.validateUser(parameters, completion: { userID in
            if(userID != 0) {
                DataTracker.setUserID(userID)
                let sl = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Successful") as! SuccessfulLoginViewController
                self.present(sl, animated: true, completion: nil)
            }
        })
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        let signUpView = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignUpView") as! SignUpViewController
        self.present(signUpView, animated: true, completion: nil)
    }
    
}

