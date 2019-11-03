//
//  DataTracker.swift
//  PasswordiOS
//
//  Created by Daniel Ramirez on 10/9/19.
//  Copyright © 2019 Daniel Ramirez. All rights reserved.
//

import Foundation

final class DataTracker {
    
    static private var userID = 0
    static var passwords : [NSDictionary] = []
    
    static func getUserID() -> Int {
        return self.userID
    }
    
    static func setUserID(_ userID : Int) {
        self.userID = userID
    }
}
