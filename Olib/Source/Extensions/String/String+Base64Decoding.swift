//
//  String+Base64Decoding.swift
//  Olib
//
//  Created by jaeyoung Yun on 2020/11/10.
//

import Foundation

extension String {
    
    func base64decoding() -> [String: Any] {
        var encodedString = self.replacingOccurrences(of: "-", with: "+").replacingOccurrences(of: "_", with: "/")

        let length = Double(encodedString.lengthOfBytes(using: .utf8))
        let requiredLength = 4 * ceil(length / 4.0)
        let paddingLength = requiredLength - length
        if paddingLength > 0 {
            let padding = "".padding(toLength: Int(paddingLength), withPad: "=", startingAt: 0)
            encodedString += padding
        }

        let decodedData = Data(base64Encoded: encodedString, options: .ignoreUnknownCharacters)!
        let decodedJson = try! JSONSerialization.jsonObject(with: decodedData, options: []) as! [String: Any]
        
        return decodedJson
    }
}
