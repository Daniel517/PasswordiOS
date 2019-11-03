//
//  AddPasswordViewController.swift
//  PasswordiOS
//
//  Created by Daniel Ramirez on 10/27/19.
//  Copyright © 2019 Daniel Ramirez. All rights reserved.
//

import SwiftUI
import TextFieldEffects
import CryptoSwift

class AddPasswordViewController : UIViewController {
    
    @IBOutlet weak var descriptionTextField: HoshiTextField!
    @IBOutlet weak var passwordTextField: HoshiTextField!
    @IBOutlet weak var confirmPasswordTextField: HoshiTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addPasswordPressed(_ sender: Any) {
        if passwordConfirmed() {
            let password : [String : Any] = [
                "user_id" : DataTracker.getUserID(),
                "password" : SecurityManager.encrypt(passwordTextField.text!),
                "description" : descriptionTextField.text!
            ]
            APIManager.savePassword(password, completion: { status in
                switch(status) {
                case 0: self.successfulSaveAlert(); break;
                default: self.failedAlert(); break;
                }
            })
        }
        
    }
    
    func encryptPassword(_ password : String) -> String {
        
        return ""
    }
    
    func passwordConfirmed() -> Bool {
        if (passwordTextField.text?.isEmpty ?? true) {
            return false
        }
        if passwordTextField.text == confirmPasswordTextField.text {
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
    
    func successfulSaveAlert() {
        let alert = UIAlertController(title: "Password saved successfully!", message: "Return to Passwords", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Passwords", style: .default, handler: { action in
            let passwords = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Passwords") as! PasswordsViewController
            self.present(passwords, animated: true, completion: nil)
        }))
        self.present(alert, animated: true)
    }
    
    func failedAlert() {
        let alert = UIAlertController(title: "Failure to store passwords", message: "Try again later", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
}
