//
//  PasswordsViewController.swift
//  PasswordiOS
//
//  Created by Daniel Ramirez on 10/25/19.
//  Copyright © 2019 Daniel Ramirez. All rights reserved.
//

import UIKit
import MGSwipeTableCell

class PasswordsViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let parameter : [String : Any] = [
            "user_id" : DataTracker.getUserID()
        ]
        APIManager.getPasswords(parameter, completion: { passwords in
            DataTracker.passwords = passwords
            self.tableView.reloadData()
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataTracker.passwords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PasswordCell") as! MGSwipeTableCell
        let cipherText = DataTracker.passwords[indexPath.row].object(forKey: "password")! as! String
        cell.textLabel!.text = SecurityManager.decrypt(cipherText)
        cell.detailTextLabel!.text = (DataTracker.passwords[indexPath.row].object(forKey: "description")! as! String)
        cell.rightButtons = [MGSwipeButton(title: "Delete", backgroundColor: .red, callback: {
            (sender: MGSwipeTableCell!) -> Bool in
            self.deleteStorePassword(indexPath.row)
            return true
            }), MGSwipeButton(title: "Edit", backgroundColor: .green, callback: {
                (sender: MGSwipeTableCell!) -> Bool in
                return true
            }), MGSwipeButton(title: "Copy", backgroundColor: .blue, callback: {
                (sender: MGSwipeTableCell!) -> Bool in
                UIPasteboard.general.string = cell.textLabel?.text
                return true
            })
        ]
        return cell
    }
    
    @IBAction func backPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addPasswordPressed(_ sender: Any) {
        let addPassword = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddPassword") as! AddPasswordViewController
        self.present(addPassword, animated: true, completion: nil)
    }
    
    func deleteStorePassword(_ index: Int) {
        let password : [String : Any] = [
            "password_id" : DataTracker.passwords[index].object(forKey: "password_id")! as! Int,
            "user_id" : DataTracker.passwords[index].object(forKey: "user_id")! as! Int
        ]
        APIManager.deletePasswords(password, completion: { status in
            if status == 0 {
                DataTracker.passwords.remove(at: index)
                self.tableView.reloadData()
            }
            else {
                self.failedAlert()
            }
        })
    }
    
    func failedAlert() {
        let alert = UIAlertController(title: "Failure to delete password", message: "Try again later", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}
