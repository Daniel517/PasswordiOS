//
//  SuccessfulLoginViewController.swift
//  PasswordiOS
//
//  Created by Daniel Ramirez on 10/9/19.
//  Copyright © 2019 Daniel Ramirez. All rights reserved.
//

import UIKit

class SuccessfulLoginViewController : UIViewController {
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "Succesfully signed in as \(String(describing: DataTracker.getUserID))"
        print("Successful View")
    }
}
