//
//  AuthManager.swift
//  Olib
//
//  Created by jaeyoung Yun on 2020/11/03.
//

import Foundation
import RxSwift

class AuthManager {
    
    static let shared = AuthManager()
    private var token = Token()
    var userId: Int?
    
    var accessToken: String? {
        if !token.isValid(tokenType: .refresh) {
            print("Refresh token is invalid.")
            return nil
        } else if !token.isValid(tokenType: .access) {
            refreshAccessToken()
        }
        return token.accessToken
    }
    
    func authenticate(with email: String, password: String, completion: @escaping (HTTPURLResponse) -> Void) {
        let credentials = ["username": email, "password": password]
        
        AuthClient().getTokens(credentials: credentials) { (response, data) in
            if response.statusCode == 200, let data = data {
                self.handleAuthenticated(data: data)
            }
            
            completion(response)
        }
    }
    
    private func refreshAccessToken() {
        AuthClient().refreshAccessToken(refreshToken: token.refreshToken!, completion: handleRefreshAccessTokenResponse)
    }
    
    private func handleRefreshAccessTokenResponse(_ response: HTTPURLResponse, _ data: Data?) {
        if response.statusCode == 200, let data = data {
            let jsonData = try! JSONSerialization.jsonObject(with: data) as! [String: String]
            self.token.accessToken = jsonData["access"]
        }
    }
    
    private func handleAuthenticated(data: Data) {
        let jsonData = try! JSONSerialization.jsonObject(with: data) as! [String: String]
        token.refreshToken = jsonData["refresh"]
        token.accessToken = jsonData["access"]
        userId = token.getUserId()
    }
    
    func signUp(with email: String, password: String, completion: @escaping (HTTPURLResponse) -> Void) {
        let credentials = ["username": email, "password": password]
        
        AuthClient().createUser(credentials: credentials) { (response, data) in
            if response.statusCode == 201, let data = data {
                self.handleAuthenticated(data: data)
            }
            
            completion(response)
        }
    }
}

extension AuthManager {
    
    func rxAuthenticate(with email: String, password: String) -> Observable<HTTPURLResponse> {
        let credentials = ["username": email, "password": password]

        return AuthClient().rxGetTokens(credentials: credentials)
            .do(onNext: { [weak self] response, data in
                if response.statusCode == 201 {
                    self?.handleAuthenticated(data: data)
                }
            })
            .map { $0.0 }
    }
    
    func rxSignUp(with email: String, password: String) -> Observable<HTTPURLResponse> {
        let credentials = ["username": email, "password": password]
        
        return AuthClient().rxCreateUser(credentials: credentials)
            .do(onNext: { [weak self] response, data in
                if response.statusCode == 201 {
                    self?.handleAuthenticated(data: data)
                }
            })
            .map { $0.0 }
    }
}
