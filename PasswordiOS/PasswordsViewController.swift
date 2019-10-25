//
//  PasswordsViewController.swift
//  PasswordiOS
//
//  Created by Daniel Ramirez on 10/25/19.
//  Copyright © 2019 Daniel Ramirez. All rights reserved.
//

import UIKit

class PasswordsViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
