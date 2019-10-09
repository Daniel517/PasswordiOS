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
        let username = usernameTextField.text!
        let password = passwordTextField.text!
        APIManager.validateUser(username, password, completion: { userID in
            if(userID != 0) {
                print("Validated")
                DataTracker.setUserID(userID)
                let sl = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Successful") as! SuccessfulLoginViewController
                self.present(sl, animated: true, completion: nil)
            }
        })
        print("Did not send")
    }
}

