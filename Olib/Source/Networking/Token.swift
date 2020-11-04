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
            return exp <= Date().timeIntervalSince1970
        }
        return false
    }
    
    enum TokenType {
        case refresh
        case access
    }
    
    private func getExpirationTime(of stringToken: String) -> TimeInterval {
        var payload = String(stringToken.split(separator: ".")[1])
            .replacingOccurrences(of: "-", with: "+").replacingOccurrences(of: "_", with: "/")

        let length = Double(payload.lengthOfBytes(using: .utf8))
        let requiredLength = 4 * ceil(length / 4.0)
        let paddingLength = requiredLength - length
        if paddingLength > 0 {
            let padding = "".padding(toLength: Int(paddingLength), withPad: "=", startingAt: 0)
            payload += padding
        }

        let payloadData = Data(base64Encoded: payload, options: .ignoreUnknownCharacters)!
        let payloadJson = try! JSONSerialization.jsonObject(with: payloadData, options: []) as! [String: Any]
        let exp = payloadJson["exp"] as! Int
        return TimeInterval(exp)
    }
}
