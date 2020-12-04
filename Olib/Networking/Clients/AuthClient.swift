//
//  AuthClient.swift
//  Olib
//
//  Created by jaeyoung Yun on 2020/11/10.
//

import Foundation
import RxSwift
import RxCocoa

struct AuthClient {
    
    func getTokens(credentials: [String: String], completion: @escaping (HTTPURLResponse, Data?) -> Void) {
        guard let request = PostTokenRequest(credentials: credentials).request(for: URL(string: ServerManager.shared.serverURL)!) else {
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let response = response as? HTTPURLResponse else {
                return
            }
            
            completion(response, data)
        }.resume()
    }

    func refreshAccessToken(refreshToken: String, completion: @escaping (HTTPURLResponse, Data?) -> Void) {
        guard let request = PostTokenRefreshRequest(refreshToken: ["refresh": refreshToken]).request(for: URL(string: ServerManager.shared.serverURL)!) else {
            print("No tokenrefreshrequest returned in getAccessToken() / \(self.self)")
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let response = response as? HTTPURLResponse else {
                return
            }
            
            completion(response, data)
        }.resume()
    }
    
    func createUser(credentials: [String: String], completion: @escaping (HTTPURLResponse, Data?) -> Void) {
        guard let request = PostUserRequest(credentials: credentials).request(for: URL(string: ServerManager.shared.serverURL)!) else {
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let response = response as? HTTPURLResponse else {
                return
            }
            
            completion(response, data)
        }.resume()
    }
}

extension AuthClient {
    
    func rxGetTokens(credentials: [String: String]) -> Observable<(response: HTTPURLResponse, data: Data)> {
        guard let request = PostTokenRequest(credentials: credentials).request(for: URL(string: ServerManager.shared.serverURL)!) else {
            return Observable.error(APIRequestError.invalidURL)
        }
        
        return URLSession.shared.rx.response(request: request)
    }
}
