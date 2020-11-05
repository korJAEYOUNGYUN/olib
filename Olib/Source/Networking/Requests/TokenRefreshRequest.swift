//
//  TokenRefreshRequest.swift
//  Olib
//
//  Created by jaeyoung Yun on 2020/11/04.
//

import Foundation

class TokenRefreshRequest: APIRequest {
    
    var path: String = "/api/token/refresh/"
    var method: HTTPMethod = .post
    var refreshToken = [String: String]()
    var accessToken: String?
    var needPermission: Bool = false
    
    init(refreshToken: [String: String]) {
        self.refreshToken = refreshToken
    }
    
    func body() -> Data? {
        return try? JSONEncoder().encode(refreshToken)
    }
}
