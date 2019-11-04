//
//  SecurityManager.swift
//  PasswordiOS
//
//  Created by Daniel Ramirez on 11/3/19.
//  Copyright © 2019 Daniel Ramirez. All rights reserved.
//

import Foundation
import CryptoSwift

final class SecurityManager {
    
    static private var salt = Array("mD1aex4e24KCs7Qn".utf8)
    static private var key = try! HKDF(password: Array("KIv9LIJjlrET1qJLrAozBhFuGsjn5eKM".utf8), salt: salt, variant: .sha256).calculate()
    static private var iv = try! PKCS5.PBKDF2(password: Array("kmv6IewWXf4zFIOy".utf8), salt: salt, iterations: 256, keyLength: 16, variant: .sha256).calculate()
    
    static func setKeyAndIV(_ keyString : String, _ ivString : String) {
        self.key = try! HKDF(password: Array(keyString.utf8), salt: salt, variant: .sha256).calculate()
        self.iv = try! PKCS5.PBKDF2(password: Array(ivString.utf8), salt: salt, iterations: 256, keyLength: 16, variant: .sha256).calculate()
    }
    
    static func encrypt(_ plainText : String) -> String {
        let aes = try! AES(key: key, blockMode: CBC(iv: iv))
        let cipherText = try! aes.encrypt(Array(plainText.utf8))
        return cipherText.toHexString()
    }
    
    static func decrypt(_ cipherText : String) -> String {
        let aes = try! AES(key: key, blockMode: CBC(iv: iv))
        let decryptText = try! aes.decrypt(Array(Data(hex: cipherText)))
        return String(bytes: decryptText, encoding: .utf8)!
    }
}
