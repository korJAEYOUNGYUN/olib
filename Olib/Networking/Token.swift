//
//  Token.swift
//  Olib
//
//  Created by jaeyoung Yun on 2020/11/03.
//

import Foundation

struct Token {
    
    var refreshToken: String? { didSet { refreshExp = getExpirationTime(of: refreshToken!) }}
    var accessToken: String? { didSet { accessExp = getExpirationTime(of: accessToken!) }}
    
    private var refreshExp: TimeInterval?
    private var accessExp: TimeInterval?
    
    func isValid(tokenType: TokenType) -> Bool {
        let exp: TimeInterval?
        
        switch tokenType {
        case .refresh:
            exp = refreshExp
        case .access:
            exp = accessExp
        }
        
        if let exp = exp {
            return exp > Date().timeIntervalSince1970
        }
        return false
    }
    
    enum TokenType {
        case refresh
        case access
    }
    
    func getUserId() -> Int? {
        guard isValid(tokenType: .refresh) else {
            return nil
        }
        let payload = String(refreshToken!.split(separator: ".")[1])
        let payloadJson = payload.base64decoding()
        
        return payloadJson["user_id"] as? Int
    }
    
    private func getExpirationTime(of stringToken: String) -> TimeInterval {
        let payload = String(stringToken.split(separator: ".")[1])
        let payloadJson = payload.base64decoding()
        let exp = payloadJson["exp"] as! Int
        
        return TimeInterval(exp)
    }
}
