//
//  TokenRequest.swift
//  Olib
//
//  Created by jaeyoung Yun on 2020/11/03.
//

import Foundation

class TokenRequest: APIRequest {
    
    var path: String = "/api/token/"
    var method: HTTPMethod = .post
    var credentials = [String: String]()
    
    init(credentials: [String: String]) {
        self.credentials = credentials
    }
    
    func body() -> Data? {
        return try? JSONEncoder().encode(credentials)
    }
}
