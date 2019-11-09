//
//  SuccessfulLoginViewController.swift
//  PasswordiOS
//
//  Created by Daniel Ramirez on 10/9/19.
//  Copyright © 2019 Daniel Ramirez. All rights reserved.
//

import UIKit

class MainMenuViewController : UIViewController {
    
    @IBOutlet weak var myPasswordsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func pressedMyPasswords(_ sender: Any) {
        let passwordsVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Passwords") as! PasswordsViewController
        self.present(passwordsVC, animated: true, completion: nil)
    }
}
