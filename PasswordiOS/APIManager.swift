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
    
    static func validateUser(_ username : String, _ password : String, completion : @escaping (_ userID : Int) -> Void) {
        var userID : Int = 0
        let url = "http://192.168.0.15:5000/password/authenticate"
        let parameters : Parameters = [
            "username" : username,
            "password" : password,
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
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
}
