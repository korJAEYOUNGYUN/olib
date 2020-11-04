//
//  AuthManager.swift
//  Olib
//
//  Created by jaeyoung Yun on 2020/11/03.
//

import Foundation

class AuthManager {
    
    static let shared = AuthManager()
    var serverURL: String
    private var token = Token()
    
    init() {
        serverURL = ServerManager.shared.serverURL
    }
    
    func authenticate(with email: String, password: String, completion: @escaping (HTTPURLResponse) -> Void) {
        let credentials = ["username": email, "password": password]
        getTokens(credentials: credentials, completion: completion)
    }
    
    func getTokens(credentials: [String: String], completion: @escaping (HTTPURLResponse) -> Void) {
        guard let request = TokenRequest(credentials: credentials).request(for: URL(string: serverURL)!) else {
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
}
