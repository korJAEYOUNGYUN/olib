//
//  APIRequest.swift
//  Olib
//
//  Created by jaeyoung Yun on 2020/11/03.
//

import Foundation

protocol APIRequest {
    
    var path: String { get }
    var method: HTTPMethod { get }
    
    func body() -> Data?
    func request(for url: URL, with queries: [String: String]?) -> URLRequest?
}

extension APIRequest{
    
    var contentType: String { return "application/json" }
    
    func request(for url: URL, with queries: [String: String]? = nil) -> URLRequest? {
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.path += path
        components?.queryItems = queries?.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        guard let url = components?.url else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = body()
        request.addValue(contentType, forHTTPHeaderField: "Content-Type")
        
        return request
    }
}
