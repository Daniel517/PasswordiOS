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
    
    static func signUp(_ parametersIn : [String : Any], completion : @escaping () -> ()) {
        let apiCall = "/signup"
        let parameters : Parameters = parametersIn
        AF.request(self.url + apiCall, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
                case .failure(_):
                    print(response.error!)
                case .success(_):
                    print(response.data!)
            }
            completion()
        }
    }
}
