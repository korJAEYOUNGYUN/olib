//
//  String+ValidateUserInfo.swift
//  Olib
//
//  Created by jaeyoung Yun on 2020/10/13.
//

import Foundation

extension String {
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    
    func isValidPassword() -> Bool {
        return self.count >= 8
    }
    
    static var EMAIL_INVALID: String {
        get {
            "ex) abc@abc.com."
        }
    }
    
    static var PASSWORD_INVALID: String {
        get {
            "Password must over 8 letters."
        }
    }

    static var NAME_REQUIRED: String {
        get {
            "Name is required."
        }
    }
}
