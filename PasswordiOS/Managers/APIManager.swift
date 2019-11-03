//
//  APIManager.swift
//  PasswordiOS
//
//  Created by Daniel Ramirez on 10/9/19.
//  Copyright © 2019 Daniel Ramirez. All rights reserved.
//

import Foundation
import Alamofire

final class APIManager {
    
    static let url = "http://192.168.0.15:5000/password"
    
    static func validateUser(_ parametersIn : [String : Any], completion : @escaping (_ userID : Int) -> Void) {
        var userID : Int = 0
        let apiCall = "/login"
        let parameters : Parameters = parametersIn
        AF.request(self.url + apiCall, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
                case .success(_):
                    let data = response.value! as! NSDictionary
                    userID = data.value(forKey: "user_id")! as! Int
                case .failure(_):
                    userID = 0
            }
            completion(userID)
        }
    }
    
    static func signUp(_ parametersIn : [String : Any], completion : @escaping (_ status: Int) -> ()) {
        let apiCall = "/signup"
        let parameters : Parameters = parametersIn
        var status : Int = 0
        AF.request(self.url + apiCall, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
                case .failure(_):
                    status = 2
                case .success(_):
                    let data = (response.value! as! NSDictionary)
                    let keys = data.allKeys as! [String]
                    for key in keys {
                        if key == "errno" {
                            status = 1
                        }
                    }
            }
            completion(status)
        }
    }
    
    static func savePassword(_ password : [String : Any], completion : @escaping (_ status : Int) -> ()) {
        let apiCall = "/savePassword"
        let parameters : Parameters = password
        var status : Int = 0
        AF.request(self.url + apiCall, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
                case .failure(_):
                    status = 2
                case .success(_):
                    let data = (response.value! as! NSDictionary)
                    let keys = data.allKeys as! [String]
                    for key in keys {
                        if key == "errno" {
                            status = 1
                        }
                    }
            }
            completion(status)
        }
    }
    
    static func getPasswords(_ userID : [String: Any], completion : @escaping (_ passwords : [NSDictionary]) -> ()) {
        let apiCall = "/getPasswords"
        let parameters : Parameters = userID
        AF.request(self.url + apiCall, method:  .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
                case .failure(_):
                    completion([])
                case .success(_):
                    let passwords = (response.value! as! [NSDictionary])
                    completion(passwords)
            }
        }
    }
    
    static func deletePasswords(_ password : [String : Any], completion : @escaping (_ status : Int) -> ()) {
        let apiCall = "/deletePassword"
        let parameters : Parameters = password
        AF.request(self.url + apiCall, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            var status : Int = 0
            switch response.result {
                case .failure(_):
                    status = 1
                case .success(_):
                    let data = (response.value! as! NSDictionary)
                    let keys = data.allKeys as! [String]
                    for key in keys {
                        if key == "errno" {
                            status = 1
                        }
                    }
            }
            completion(status)
        }
    }
}
