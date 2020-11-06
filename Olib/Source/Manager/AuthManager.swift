//
//  AuthManager.swift
//  Olib
//
//  Created by jaeyoung Yun on 2020/11/03.
//

import Foundation

class AuthManager {
    
    static let shared = AuthManager()
    private var token = Token()
    
    var accessToken: String? {
        if !token.isValid(tokenType: .refresh) {
            return nil
        } else if !token.isValid(tokenType: .access) {
            getAccessToken()
        }
        return token.accessToken
    }
    
    func authenticate(with email: String, password: String, completion: @escaping (HTTPURLResponse) -> Void) {
        let credentials = ["username": email, "password": password]
        getTokens(credentials: credentials, completion: completion)
    }
    
    private func getTokens(credentials: [String: String], completion: @escaping (HTTPURLResponse) -> Void) {
        guard let request = TokenRequest(credentials: credentials).request(for: URL(string: ServerManager.shared.serverURL)!) else {
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let response = response as? HTTPURLResponse else {
                return
            }
            
            if response.statusCode == 200, let data = data {
                let jsonData = try! JSONSerialization.jsonObject(with: data) as! [String: String]
                self.token.refreshToken = jsonData["refresh"]
                self.token.accessToken = jsonData["access"]
            }
            
            completion(response)
        }.resume()
    }
    
    private func getAccessToken() {
        guard let request = TokenRefreshRequest(refreshToken: ["refresh": token.refreshToken!]).request(for: URL(string: ServerManager.shared.serverURL)!) else {
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let response = response as? HTTPURLResponse else {
                return
            }
            
            if response.statusCode == 200, let data = data {
                let jsonData = try! JSONSerialization.jsonObject(with: data) as! [String: String]
                self.token.accessToken = jsonData["access"]
            }
        }
    }
}
